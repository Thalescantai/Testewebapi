class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    if logged_in?
      redirect_to root_path, notice: "Você já está autenticado."
      return
    end
  end

  def create
    user = User.find_by(cpf: normalized_cpf)

    if user&.authenticate(session_params[:password])
      complete_login_flow(user)
    else
      flash.now[:alert] = "CPF ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path, notice: "Sessão encerrada com sucesso."
  end

  private

  def session_params
    params.require(:session).permit(:cpf, :password, :remember_me)
  end

  def normalized_cpf
    session_params[:cpf].to_s.gsub(/\D/, "")
  end

  def complete_login_flow(user)
    log_in(user)
    if ActiveModel::Type::Boolean.new.cast(session_params[:remember_me])
      remember(user)
    else
      forget(user)
    end
    user.update_columns(last_login_at: Time.current)
    redirect_to root_path, notice: "Bem-vindo, #{user.name.split.first}!"
  end
end
