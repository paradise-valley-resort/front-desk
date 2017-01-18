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
end
