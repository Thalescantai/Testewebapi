class ExamesController < ApplicationController
  before_action :set_exame, only: %i[ show edit update destroy ]
  before_action :set_collections, only: %i[new edit create update]

  # GET /exames or /exames.json
  def index
    @exames = Exame.includes(consulta: :medico).order(created_at: :desc)
  end

  # GET /exames/1 or /exames/1.json
  def show
  end

  # GET /exames/new
  def new
    @exame = Exame.new
  end

  # GET /exames/1/edit
  def edit
  end

  # POST /exames or /exames.json
  def create
    @exame = Exame.new(exame_params)

    respond_to do |format|
      if @exame.save
        format.html { redirect_to @exame, notice: "Exame was successfully created." }
        format.json { render :show, status: :created, location: @exame }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exames/1 or /exames/1.json
  def update
    respond_to do |format|
      if @exame.update(exame_params)
        format.html { redirect_to @exame, notice: "Exame was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @exame }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exames/1 or /exames/1.json
  def destroy
    @exame.destroy!

    respond_to do |format|
      format.html { redirect_to exames_path, notice: "Exame was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exame
      @exame = Exame.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exame_params
      params.require(:exame).permit(:consulta_id, :tipo_exame, :data_solicitacao, :data_marcada, :data_realizada, :status, :observacoes)
    end

    def set_collections
      @consultas = Consulta.includes(:medico).order(data_hora: :desc)
      @status_options = Exame.status_options_for_select
    end
end
