class ConsultasController < ApplicationController
  STATUS_FILTERS = %w[todos checkin_realizado agendado atendido_recepcao pacientes_atendidos cancelado].freeze
  TIME_FILTERS = %w[day 1h 2h 4h check_in].freeze

  before_action :set_consulta, only: %i[show edit update destroy checkin iniciar_atendimento]
  before_action :set_profissional_options, only: %i[new edit create update iniciar_atendimento index]
  before_action :set_paciente_from_params, only: %i[new create]
  before_action :set_paciente_options, only: %i[new edit create update iniciar_atendimento]

  def index
    @filter_date = reference_date
    @status_filter = STATUS_FILTERS.include?(params[:status_filter]) ? params[:status_filter] : "todos"
    @time_filter = TIME_FILTERS.include?(params[:time_filter]) ? params[:time_filter] : "day"
    @selected_professional_id = params[:professional_id].presence
    @search_term = params[:search].to_s.strip

    @consultas = Consulta.includes(:medico, :exames, paciente: :endereco)
    @consultas = apply_date_time_filter(@consultas)
    @consultas = @consultas.where(medico_id: @selected_professional_id) if @selected_professional_id.present?
    @consultas = apply_status_filter(@consultas)
    @consultas = apply_search_filter(@consultas)
    @consultas = @consultas.order(:data_hora)
  end

  def medico
    intervalo_dia = Time.zone.today.beginning_of_day..Time.zone.today.end_of_day

    @consultas_hoje = Consulta.includes(:paciente, :medico)
                              .where(data_hora: intervalo_dia)
                              .order(:data_hora)

    @checkins_realizados = Consulta.includes(:paciente, :medico)
                                   .where(checkin: true, data_hora: intervalo_dia)
                                   .order(:data_hora)
  end

  def show; end

  def iniciar_atendimento
    render :atendimento
  end

  def new
    @consulta = Consulta.new(paciente: @paciente)
  end

  def edit; end

  def create
    @consulta = Consulta.new(consulta_params)
    @consulta.paciente ||= @paciente

    respond_to do |format|
      if @consulta.save
        destino = @consulta.paciente || @consulta
        format.html { redirect_to destino, notice: "Consulta criada e vinculada ao paciente." }
        format.json { render :show, status: :created, location: @consulta }
      else
        set_paciente_options
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @consulta.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    finalizando = params[:finalizar_atendimento].present?

    @consulta.assign_attributes(consulta_params)
    @consulta.status = :finalizado if finalizando
    @consulta.checkin = true if finalizando && !@consulta.checkin?

    respond_to do |format|
      if @consulta.save
        destino = finalizando ? exames_path : (@consulta.paciente || @consulta)
        aviso = finalizando ? "Atendimento finalizado. Exames encaminhados para análise." : "Consulta atualizada com sucesso."
        format.html { redirect_to destino, notice: aviso, status: :see_other }
        format.json { render :show, status: :ok, location: @consulta }
      else
        template = finalizando ? :atendimento : :edit
        format.html { render template, status: :unprocessable_entity }
        format.json { render json: @consulta.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @consulta.destroy!

    respond_to do |format|
      destino = @consulta.paciente || consultas_path
      format.html { redirect_to destino, notice: "Consulta removida com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def checkin
    respond_to do |format|
      if @consulta.checkin?
        format.html { redirect_to consultas_path, notice: "Check-in já havia sido realizado para esta consulta.", status: :see_other }
        format.json { render :show, status: :ok, location: @consulta }
      else
        novo_status = @consulta.finalizado? ? :finalizado : :atendido
        if @consulta.update(checkin: true, status: novo_status)
          format.html { redirect_to consultas_path, notice: "Check-in realizado com sucesso.", status: :see_other }
          format.json { render :show, status: :ok, location: @consulta }
        else
          format.html { redirect_to consultas_path, alert: "Não foi possível registrar o check-in.", status: :see_other }
          format.json { render json: @consulta.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def set_consulta
    @consulta = Consulta.includes(:exames).find(params[:id])
    @paciente = @consulta.paciente
    if %w[edit iniciar_atendimento].include?(action_name) && @consulta.exames.empty?
      @consulta.exames.build
    end
  end

  def consulta_params
    params.require(:consulta).permit(:medico_id, :paciente_id, :data_hora, :tipo, :diagnostico, :checkin, :status,
                                     exames_attributes: %i[id nome_exame data_exame observacao_exame status _destroy])
  end

  def set_profissional_options
    @medicos = Profissional.cargo_medico.order(:nome)
  end

  def set_paciente_options
    @pacientes = Paciente.order(:nome)
  end

  def set_paciente_from_params
    paciente_id = params[:paciente_id] || params.dig(:consulta, :paciente_id)
    @paciente = Paciente.find_by(id: paciente_id) if paciente_id.present?
  end

  def reference_date
    raw_date = params[:filter_date]
    return Time.zone.today unless raw_date.present?

    Date.parse(raw_date)
  rescue ArgumentError
    Time.zone.today
  end

  def apply_date_time_filter(scope)
    day_range = @filter_date.beginning_of_day..@filter_date.end_of_day

    case @time_filter
    when "1h", "2h", "4h"
      hours = @time_filter.to_i.hours
      start_time = @filter_date == Time.zone.today ? [Time.zone.now, @filter_date.beginning_of_day].max : @filter_date.beginning_of_day
      end_time = [start_time + hours, @filter_date.end_of_day].min
      scope.where(data_hora: start_time..end_time)
    when "check_in"
      scope.where(checkin: false, data_hora: day_range)
    else
      scope.where(data_hora: day_range)
    end
  end

  def apply_status_filter(scope)
    case @status_filter
    when "checkin_realizado"
      scope.where(checkin: true)
    when "agendado"
      scope.agendado
    when "atendido_recepcao"
      scope.atendido
    when "pacientes_atendidos"
      scope.finalizado
    when "cancelado"
      scope.where(status: :faltou)
    else
      scope
    end
  end

  def apply_search_filter(scope)
    return scope if @search_term.blank?

    normalized_term = ActiveRecord::Base.sanitize_sql_like(@search_term.downcase)
    term = "%#{normalized_term}%"
    cpf_digits = @search_term.gsub(/\D/, "")

    conditions = [
      "LOWER(pacientes.nome) LIKE :term",
      "LOWER(profissionais.nome) LIKE :term",
      "LOWER(consultas.tipo) LIKE :term",
      "LOWER(consultas.diagnostico) LIKE :term"
    ]
    paciente_fields = %w[
      cpf sexo data_nascimento celular email nome_social horario observacao cartao_sus profissao rg org_exp
      escolaridade raca nacionalidade estado_civil naturalidade nome_mae
    ]
    endereco_fields = %w[rua numero bairro cep cidade complemento logradouro]

    paciente_fields.each do |field|
      conditions << "LOWER(CAST(pacientes.#{field} AS TEXT)) LIKE :term"
    end

    endereco_fields.each do |field|
      conditions << "LOWER(CAST(enderecos.#{field} AS TEXT)) LIKE :term"
    end

    query_params = { term: term }

    if cpf_digits.present?
      query_params[:cpf_term] = "%#{cpf_digits}%"
      conditions << "pacientes.cpf LIKE :cpf_term"
    else
      query_params[:cpf_fallback] = "%#{@search_term.strip}%"
      conditions << "pacientes.cpf LIKE :cpf_fallback"
    end

    scope.left_outer_joins(:medico, paciente: :endereco)
         .where(conditions.map { |clause| "(#{clause})" }.join(" OR "), query_params)
  end
end
