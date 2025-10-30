class ConsultasController < ApplicationController
  before_action :set_consulta, only: %i[show edit update destroy checkin iniciar_atendimento]
  before_action :set_profissional_options, only: %i[new edit create update iniciar_atendimento]
  before_action :set_paciente_from_params, only: %i[new create]
  before_action :set_paciente_options, only: %i[new edit create update iniciar_atendimento]

  def index
    @consultas = Consulta.includes(:medico, :paciente, :exames).order(data_hora: :desc)
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
end
