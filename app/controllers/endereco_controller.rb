class EnderecoController < ApplicationController
  before_action :set_endereco, only: %i[ show edit update destroy ]
  before_action :set_paciente_from_params, only: %i[new create]

  # GET /endereco
  def index
    @enderecos = Endereco.all.order(created_at: :desc)
  end

  # GET /endereco/1
  def show
  end

  # GET /endereco/new
  def new
    @endereco = Endereco.new(paciente: @paciente)
  end

  # GET /endereco/1/edit
  def edit
  end

  # POST /endereco
  def create
    @endereco = Endereco.new(endereco_params)
    @endereco.paciente ||= @paciente

    respond_to do |format|
      if @endereco.save
        destino = if @endereco.paciente.present?
                    new_consulta_path(paciente_id: @endereco.paciente_id)
                  else
                    endereco_path(@endereco)
                  end
        format.html { redirect_to destino, notice: "Endereço criado com sucesso." }
        format.json { render :show, status: :created, location: @endereco }
      else
        set_paciente_from_params unless @paciente
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @endereco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /endereco/1
  def update
    respond_to do |format|
      if @endereco.update(endereco_params)
        destino = @endereco.paciente.present? ? @endereco.paciente : @endereco
        format.html { redirect_to destino, notice: "Endereço atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @endereco }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @endereco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /endereco/1
  def destroy
    @endereco.destroy!
    respond_to do |format|
      destino = @endereco.paciente.present? ? @endereco.paciente : enderecos_path
      format.html { redirect_to destino, notice: "Endereço excluído com sucesso." }
      format.json { head :no_content }
    end
  end

  private

  # 🔹 Localiza o registro
  def set_endereco
    @endereco = Endereco.find(params[:id])
  end

  # 🔹 Permite apenas parâmetros seguros
  def endereco_params
    params.require(:endereco).permit(:rua, :numero, :bairro, :cep, :cidade, :complemento, :logradouro, :paciente_id)
  end

  def set_paciente_from_params
    paciente_id = params[:paciente_id] || params.dig(:endereco, :paciente_id)
    @paciente = Paciente.find_by(id: paciente_id) if paciente_id.present?
  end
end
