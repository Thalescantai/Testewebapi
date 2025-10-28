class ConsultasController < ApplicationController
  before_action :set_consulta, only: %i[show edit update destroy]
  before_action :set_profissional_options, only: %i[new edit create update]

  def index
    @consultas = Consulta.includes(:medico).all
  end

  def show; end

  def new
    @consulta = Consulta.new
  end

  def edit; end

  def create
    @consulta = Consulta.new(consulta_params)

    respond_to do |format|
      if @consulta.save
        format.html { redirect_to @consulta, notice: "Consulta was successfully created." }
        format.json { render :show, status: :created, location: @consulta }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @consulta.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @consulta.update(consulta_params)
        format.html { redirect_to @consulta, notice: "Consulta was successfully updated.", status: :see_other }
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
      format.html { redirect_to consultas_path, notice: "Consulta was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_consulta
    @consulta = Consulta.find(params[:id])
  end

  def consulta_params
    params.require(:consulta).permit(:medico_id, :data_hora, :tipo, :anamnese, :diagnostico)
  end

  def set_profissional_options
    @medicos = Profissional.cargo_medico.order(:nome)
  end
end
