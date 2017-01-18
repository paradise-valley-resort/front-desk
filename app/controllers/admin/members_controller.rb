class Admin::MembersController < Admin::ApplicationController
  def index
    @members = Member.ordered.page(params[:page])
  end

  def new
    @member = build_member
  end

  def create
    @member = build_member(member_params)
    if @member.save
      redirect_to admin_members_path,
        flash: { success: "Member was successfully created." }
    else
      render :new
    end
  end

  def edit
    @member = find_member
  end

  def update
    @member = find_member
    if @member.update_attributes(member_params)
      redirect_to admin_members_path,
        flash: { success: "Member was successfully updated." }
    else
      render :edit
    end
  end

  private

  def build_member(member_params = {})
    Member.new(member_params)
  end

  def find_member
    Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(
      :first_name,
      :last_name,
      :address_1,
      :address_2,
      :city,
      :state,
      :zip_code,
      :phone,
      :email,
      :membership_id
    )
  end
end
