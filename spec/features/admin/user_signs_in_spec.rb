require "rails_helper"

feature "User signs in" do
  scenario "and sees error message when account has been deactivated" do
    user = create(:user, :deactivated)

    visit new_user_session_path
    fill_out_login_form(email: user.email, password: user.password)

    expect(page).to have_content("Your account has been deactivated")
  end

  def fill_out_login_form(user_attributes = {})
    user = build(:user, {}.merge(user_attributes))
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Sign in"
  end
end
