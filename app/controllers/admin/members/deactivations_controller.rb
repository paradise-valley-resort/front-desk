class Admin::Members::DeactivationsController < Admin::ApplicationController
  def create
    @member = find_member
    @member.touch(:deactivated_at)
    redirect_back(
      fallback_location: admin_members_path,
      flash: { success: "Member was successfully deactivated." }
    )
  end

  private

  def find_member
    Member.find(params[:member_id])
  end
end
