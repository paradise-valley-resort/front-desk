class Admin::UsersController < Admin::ApplicationController
  def index
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

  private

  def build_user(user_params = {})
    User.new(user_params)
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
