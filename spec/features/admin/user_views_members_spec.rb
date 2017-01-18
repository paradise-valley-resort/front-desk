require "rails_helper"

feature "User views members" do
  scenario "is redirected away if not signed in" do
    visit admin_members_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "successfully" do
    sign_in create(:user)
    visit admin_members_path

    expect(current_path).to eq(admin_members_path)
  end

  scenario "by navigating from site header" do
    sign_in create(:user)
    visit admin_root_path
    click_on "Members"

    expect(current_path).to eq(admin_members_path)
  end

  scenario "and sees list of members" do
    member = create(:member)

    sign_in create(:user)
    visit admin_members_path

    expect(page).to have_content(member.full_name)
  end

  scenario "and chooses to create a new member" do
    sign_in create(:user)
    visit admin_members_path
    click_on "Add member"

    expect(current_path).to eq(new_admin_member_path)
  end

  scenario "and chooses to edit a member" do
    member = create(:member)

    sign_in create(:user)
    visit admin_members_path
    within "#member_#{member.to_param}" do
      find(".manage-member").click
      click_on "Edit member"
    end

    expect(current_path).to eq(edit_admin_member_path(member))
  end

  scenario "and chooses to filter the list of members by all statuses" do
    active_member = create(:member, :active)
    deactivated_member = create(:member, :deactivated)

    sign_in create(:user)
    visit admin_members_path
    click_on "All"

    expect(page).to have_content(active_member.membership_id)
    expect(page).to have_content(deactivated_member.membership_id)
  end

  scenario "and chooses to filter the list of members by active status" do
    active_member = create(:member, :active)
    deactivated_member = create(:member, :deactivated)

    sign_in create(:user)
    visit admin_members_path
    click_on "Active"

    expect(page).to have_content(active_member.membership_id)
    expect(page).not_to have_content(deactivated_member.membership_id)
  end

  scenario "and chooses to filter the list of members by deactive status" do
    deactivated_member = create(:member, :deactivated)
    active_member = create(:member, :active)

    sign_in create(:user)
    visit admin_members_path
    click_on "Deactive"

    expect(page).to have_content(deactivated_member.membership_id)
    expect(page).not_to have_content(active_member.membership_id)
  end
end
