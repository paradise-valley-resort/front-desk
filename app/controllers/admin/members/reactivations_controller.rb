class Admin::Members::ReactivationsController < Admin::ApplicationController
  def create
    @member = find_member
    @member.update_attributes(deactivated_at: nil)
    redirect_back(
      fallback_location: admin_members_path,
      flash: { success: "Member was successfully reactivated." }
    )
  end

  private

  def find_member
    Member.find(params[:member_id])
  end
end
