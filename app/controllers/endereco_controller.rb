class EnderecoController < ApplicationController
  before_action :set_endereco, only: %i[ show edit update destroy ]

  # GET /endereco
  def index
    @enderecos = Endereco.all.order(created_at: :desc)
  end

  # GET /endereco/1
  def show
  end

  # GET /endereco/new
  def new
    @endereco = Endereco.new
  end

  # GET /endereco/1/edit
  def edit
  end

  # POST /endereco
  def create
    @endereco = Endereco.new(endereco_params)

    respond_to do |format|
      if @endereco.save
        format.html { redirect_to @endereco, notice: "Endereço criado com sucesso." }
        format.json { render :show, status: :created, location: @endereco }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @endereco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /endereco/1
  def update
    respond_to do |format|
      if @endereco.update(endereco_params)
        format.html { redirect_to @endereco, notice: "Endereço atualizado com sucesso." }
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
      format.html { redirect_to endereco_index_path, notice: "Endereço excluído com sucesso." }
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
    params.require(:endereco).permit(:rua, :numero, :bairro, :cep, :cidade, :complemento, :logradouro)
  end
end
