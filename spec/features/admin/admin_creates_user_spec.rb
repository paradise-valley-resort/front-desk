require "rails_helper"

feature "Admin creates user" do
  scenario "is redirected away if not signed in" do
    visit new_admin_user_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "is redirected away if not an admin" do
    sign_in create(:user)
    visit new_admin_user_path

    expect(current_path).to eq(admin_root_path)
  end

  scenario "with an email address that has already been taken" do
    existing_user = create(:user, email: "already_taken@example.com")

    sign_in create(:user, :admin)
    visit new_admin_user_path
    fill_out_user_form(email: existing_user.email)

    within ".user_email" do
      expect(page).to have_content("Email has already been taken")
    end
  end

  scenario "with invalid attributes and sees error message" do
    sign_in create(:user, :admin)
    visit new_admin_user_path
    fill_out_user_form(email: "")

    expect(page).to have_content("There were problems creating the user account")
    expect(page).to have_content("Email can't be blank")
  end

  scenario "with valid attributes and sees success message" do
    sign_in create(:user, :admin)
    visit new_admin_user_path
    fill_out_user_form

    expect(page).to have_content("User was successfully created.")
  end

  def fill_out_user_form(user_attributes = {})
    user = build(:user, {}.merge(user_attributes))
    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password, match: :prefer_exact
    fill_in "Password Confirmation", with: user.password, match: :prefer_exact
    click_on "Create account"
  end
end
