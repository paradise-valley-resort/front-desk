class Admin::Users::DemotionsController < Admin::ApplicationController
  def create
    @user = find_user
    authorize @user, :demote?
    @user.update_attributes(admin: false)
    redirect_back(
      fallback_location: admin_users_path,
      flash: { success: "Admin access was successfully removed." }
    )
  end

  private

  def find_user
    User.find(params[:user_id])
  end
end
