require "rails_helper"

feature "Admin promotes user" do
  scenario "and sees success message" do
    user = create(:user)

    sign_in create(:user, :admin)
    visit admin_users_path
    within "#user_#{user.to_param}" do
      find(".manage-user").click
      click_on "Grant admin access"
    end

    expect(page).to have_content("Admin access was successfully granted")
  end
end
