require "rails_helper"

feature "Admin updates user" do
  scenario "is redirected away if not signed in" do
    user = create(:user)

    visit edit_admin_user_path(user)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "is redirected away if not an admin" do
    user = create(:user)

    sign_in user
    visit edit_admin_user_path(user)

    expect(current_path).to eq(authenticated_admin_root_path)
  end

  scenario "with an email address that has already been taken" do
    user = create(:user)
    other_user = create(:user, email: "already_taken@example.com")

    sign_in create(:user, :admin)
    visit edit_admin_user_path(user)
    fill_in "Email", with: other_user.email
    click_on "Update account"

    within ".user_email" do
      expect(page).to have_content("Email has already been taken")
    end
  end

  scenario "with mismatched password and password confirmation" do
    user = create(:user)

    sign_in create(:user, :admin)
    visit edit_admin_user_path(user)
    fill_in "Password", with: "new_password", match: :prefer_exact
    fill_in "Password Confirmation", with: "different_password", match: :prefer_exact
    click_on "Update account"

    within ".user_password_confirmation" do
      expect(page).to have_content("Password Confirmation doesn't match Password")
    end
  end

  scenario "with invalid attributes and sees error message" do
    user = create(:user)

    sign_in create(:user, :admin)
    visit edit_admin_user_path(user)
    fill_in "Email", with: ""
    click_on "Update account"

    expect(page).to have_content("There were problems updating the user account")
    within ".user_email" do
      expect(page).to have_content("Email can't be blank")
    end
  end

  scenario "is unable to change his own admin access" do
    admin = create(:user, :admin)

    sign_in admin
    visit edit_admin_user_path(admin)

    expect(page).not_to have_content("Grant admin access?")
  end

  scenario "with valid attributes and sees success message" do
    user = create(:user)

    sign_in create(:user, :admin)
    visit edit_admin_user_path(user)
    fill_in "Last Name", with: "New Last Name"
    click_on "Update account"

    expect(page).to have_content("User was successfully updated")
  end
end
