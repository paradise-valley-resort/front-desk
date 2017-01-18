require "rails_helper"

feature "User reactivates member" do
  scenario "and sees success message" do
    member = create(:member, :deactivated)

    sign_in create(:user)
    visit admin_members_path
    within "#member_#{member.to_param}" do
      find(".manage-member").click
      click_on "Reactivate member"
    end

    expect(page).to have_content("Member was successfully reactivated")
  end
end
