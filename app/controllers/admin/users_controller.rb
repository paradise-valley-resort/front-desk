class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.ordered.page(params[:page])
    authorize @users
  end

  def new
    @user = build_user
    authorize @user
  end

  def create
    @user = build_user(user_params)
    authorize @user
    if @user.save
      redirect_to admin_users_path,
        flash: { success: "User was successfully created." }
    else
      render :new
    end
  end

  def edit
    @user = find_user
    authorize @user
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user = find_user
    authorize @user
    if @user.update_attributes(user_params)
      redirect_to admin_users_path,
        flash: { success: "User was successfully updated." }
    else
      render :edit
    end
  end

  private

  def build_user(user_params = {})
    User.new(user_params)
  end

  def find_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :admin
    )
  end
end
