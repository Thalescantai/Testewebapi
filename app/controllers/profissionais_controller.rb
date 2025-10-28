class ProfissionaisController < ApplicationController
  before_action :set_profissional, only: %i[show edit update destroy]

  def index
    @profissionais = Profissional.order(:nome)
  end

  def show; end

  def new
    @profissional = Profissional.new
  end

  def edit; end

  def create
    @profissional = Profissional.new(profissional_params)

    respond_to do |format|
      if @profissional.save
        format.html { redirect_to @profissional, notice: "Profissional was successfully created." }
        format.json { render :show, status: :created, location: @profissional }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profissional.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @profissional.update(profissional_params)
        format.html { redirect_to @profissional, notice: "Profissional was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @profissional }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profissional.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profissional.destroy!

    respond_to do |format|
      format.html { redirect_to profissionais_path, notice: "Profissional was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_profissional
    @profissional = Profissional.find(params[:id])
  end

  def profissional_params
    params.require(:profissional).permit(:nome, :email, :telefone, :cpf, :cargo)
  end
end
