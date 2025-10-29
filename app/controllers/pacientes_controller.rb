class PacientesController < ApplicationController
  before_action :set_paciente, only: %i[ show edit update destroy ]

  # GET /pacientes or /pacientes.json
  def index
    sanitize_cpf_filter
    @q = Paciente.ransack(params[:q])
    @pacientes = @q.result.order(created_at: :desc).page(params[:page]).per(10)
    @consultas_hoje_count = Consulta.where(data_hora: Time.zone.today.all_day).count
  end


  # GET /pacientes/1 or /pacientes/1.json
  def show
  end

  # GET /pacientes/new
  def new
    @paciente = Paciente.new
  end

  # GET /pacientes/1/edit
  def edit
  end

  # POST /pacientes or /pacientes.json
  def create
    @paciente = Paciente.new(paciente_params)

    respond_to do |format|
      if @paciente.save
        format.html { redirect_to @paciente, notice: "Paciente was successfully created." }
        format.json { render :show, status: :created, location: @paciente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pacientes/1 or /pacientes/1.json
  def update
    respond_to do |format|
      if @paciente.update(paciente_params)
        format.html { redirect_to @paciente, notice: "Paciente was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @paciente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pacientes/1 or /pacientes/1.json
  def destroy
    @paciente.destroy!

    respond_to do |format|
      format.html { redirect_to pacientes_path, notice: "Paciente was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paciente
      @paciente = Paciente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def paciente_params
    params.require(:paciente).permit(
      :nome,
      :cpf,
      :sexo,
      :data_nascimento,
      :celular,
      :email,
      :nome_social,
      :horario,
      :observacao,
      :cartao_sus,
      :profissao,
      :rg,
      :org_exp,
      :escolaridade,
      :raca,
      :nacionalidade,
      :estado_civil,
      :naturalidade,
      :nome_mae
    )
  end

  def sanitize_cpf_filter
    return unless params[:q].is_a?(ActionController::Parameters) || params[:q].is_a?(Hash)

    cpf_filter = params[:q][:cpf_cont]
    return if cpf_filter.blank?

    params[:q][:cpf_cont] = cpf_filter.gsub(/\D/, "")
  end
end
