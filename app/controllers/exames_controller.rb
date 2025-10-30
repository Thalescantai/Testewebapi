class ExamesController < ApplicationController
  before_action :set_exame, only: %i[ show edit update destroy realizar concluir_realizacao remarcar ]
  before_action :set_collections, only: %i[new edit create update remarcar]
  before_action :set_consulta, only: :por_consulta

  # GET /exames or /exames.json
  def index
    pendentes_keys = Exame::STATUS_LABELS.keys - %w[realizado anexado]
    pendentes_status = Exame.statuses.slice(*pendentes_keys).values
    @pendentes_keys = pendentes_keys
    @consultas_para_exames = Consulta.finalizado
                                     .joins(:exames)
                                     .where(exames: { status: pendentes_status })
                                     .includes(:paciente, :exames, :medico)
                                     .distinct
                                     .order(updated_at: :desc)
  end

  # GET /exames/1 or /exames/1.json
  def show
  end

  def por_consulta
    @exames = @consulta.exames.order(:created_at)
  end

  def realizar; end

  def concluir_realizacao
    realizacao_attrs = exame_realizacao_params
    houve_dados = realizacao_attrs.values.any?(&:present?)

    @exame.assign_attributes(realizacao_attrs)
    @exame.status = :realizado if houve_dados

    respond_to do |format|
      if @exame.save
        format.html { redirect_to consulta_exames_path(@exame.consulta), notice: "Exame atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @exame }
      else
        format.html { render :realizar, status: :unprocessable_entity }
        format.json { render json: @exame.errors, status: :unprocessable_entity }
      end
    end
  end

  def remarcar
    @redirect_to_consulta = true
    render :edit
  end

  # GET /exames/new
  def new
    @exame = Exame.new
  end

  # GET /exames/1/edit
  def edit
    @redirect_to_consulta = params[:redirect_to_consulta].present? unless defined?(@redirect_to_consulta)
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
    @redirect_to_consulta = params[:redirect_to_consulta].present? unless defined?(@redirect_to_consulta)
    respond_to do |format|
      if @exame.update(exame_params)
        destino = @redirect_to_consulta ? consulta_exames_path(@exame.consulta) : @exame
        format.html { redirect_to destino, notice: "Exame was successfully updated.", status: :see_other }
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
      params.require(:exame).permit(:consulta_id, :nome_exame, :data_exame, :status, :observacao_exame, :data_realizacao, :profissional_realizou_exame, :arquivo_resultado)
    end

    def exame_realizacao_params
      params.require(:exame).permit(:data_realizacao, :profissional_realizou_exame, :arquivo_resultado)
    end

    def set_collections
      @consultas = Consulta.includes(:medico).order(data_hora: :desc)
      @status_options = Exame.status_options_for_select
    end

    def set_consulta
      @consulta = Consulta.includes(:paciente, :medico, :exames).find(params[:consulta_id])
    end
end
