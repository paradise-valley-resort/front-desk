class Admin::Users::PromotionsController < Admin::ApplicationController
  def create
    @user = find_user
    authorize @user
    @user.update_attributes(admin: true)
    redirect_back(
      fallback_location: admin_users_path,
      flash: { success: "Admin access was successfully granted." }
    )
  end

  private

  def find_user
    User.find(params[:user_id])
  end
end
