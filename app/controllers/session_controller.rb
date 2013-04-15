class SessionController < ApplicationController

  def new
  end

  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "Nombre de usuario y/o contraseña incorrecto"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end