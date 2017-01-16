require "rails_helper"

feature "Admin reactivates user" do
  scenario "and sees success message" do
    user = create(:user, :deactivated)

    sign_in create(:user, :admin)
    visit admin_users_path
    within "#user_#{user.to_param}" do
      find(".manage-user").click
      click_on "Reactivate user"
    end

    expect(page).to have_content("User was successfully reactivated")
  end
end
