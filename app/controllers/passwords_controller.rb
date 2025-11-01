class PasswordsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    cpf = normalized_cpf
    user = User.find_by(cpf: cpf)

    if user
      flash[:notice] = "Enviamos instruções para redefinição de senha ao responsável pelo cadastro."
      redirect_to login_path
    else
      flash.now[:alert] = "CPF não encontrado em nossa base."
      render :new, status: :not_found
    end
  end

  private

  def password_params
    params.require(:password).permit(:cpf)
  end

  def normalized_cpf
    password_params[:cpf].to_s.gsub(/\D/, "")
  end
end
