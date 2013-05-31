class UsersController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy, :change_password, :change_password_update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Usuario creado correctamente"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.updating_password = false # prevent password validation
    if @user.update_attributes(params[:user])
      flash[:success] = "Usuario actualizado correctamente"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario borrado correctamente"
    redirect_to users_path
  end

  def change_password
    @user = User.find(params[:id])
  end

  def change_password_update
    @user = User.find(params[:id])
    @user.updating_password = true
    if ((params[:user][:password] == params[:user][:password_confirmation]) && !params[:user][:password_confirmation].blank?)
      @user.password_confirmation = params[:user][:password_confirmation]
      @user.password = params[:user][:password]
      if @user.save
        flash[:success] = "El password se ha actualizado correctamente"
        redirect_to @user
      else
        flash[:error] = "El password no se ha cambiado"
        render 'change_password'
      end
    else
      flash[:alert] = "El password y la confirmacion de password deben ser iguales"
      render 'change_password'
    end
  end

  private
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end