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
end
