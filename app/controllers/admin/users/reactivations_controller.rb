class Admin::Users::ReactivationsController < Admin::ApplicationController
  def create
    @user = find_user
    authorize @user
    @user.update_attributes(deactivated_at: nil)
    redirect_back(
      fallback_location: admin_users_path,
      flash: { success: "User was successfully reactivated." }
    )
  end

  private

  def find_user
    User.find(params[:user_id])
  end
end
