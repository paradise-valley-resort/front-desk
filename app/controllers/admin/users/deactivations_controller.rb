class Admin::Users::DeactivationsController < Admin::ApplicationController
  def create
    @user = find_user
    authorize @user
    @user.touch(:deactivated_at)
    redirect_back(
      fallback_location: admin_users_path,
      flash: { success: "User was successfully deactivated." }
    )
  end

  private

  def find_user
    User.find(params[:user_id])
  end
end
