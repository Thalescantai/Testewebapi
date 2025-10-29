class ConsultasController < ApplicationController
  before_action :set_consulta, only: %i[show edit update destroy]
  before_action :set_profissional_options, only: %i[new edit create update]
  before_action :set_paciente_from_params, only: %i[new create]
  before_action :set_paciente_options, only: %i[new edit create update]

  def index
    @consultas = Consulta.includes(:medico, :paciente).order(data_hora: :desc)
  end

  def show; end

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
    respond_to do |format|
      if @consulta.update(consulta_params)
        destino = @consulta.paciente || @consulta
        format.html { redirect_to destino, notice: "Consulta atualizada com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @consulta }
      else
        format.html { render :edit, status: :unprocessable_entity }
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

  private

  def set_consulta
    @consulta = Consulta.find(params[:id])
    @paciente = @consulta.paciente
  end

  def consulta_params
    params.require(:consulta).permit(:medico_id, :paciente_id, :data_hora, :tipo, :anamnese, :diagnostico)
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
