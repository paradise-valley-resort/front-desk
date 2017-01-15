require "rails_helper"

feature "Admin views users" do
  scenario "is redirected away if not signed in" do
    visit admin_users_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "is redirected away if not an admin" do
    sign_in create(:user)
    visit admin_users_path

    expect(current_path).to eq(admin_root_path)
  end

  scenario "successfully" do
    user = create(:user)

    sign_in create(:user, :admin)
    visit admin_users_path

    expect(current_path).to eq(admin_users_path)
  end

  scenario "by navigating from site header" do
    user = create(:user)

    sign_in create(:user, :admin)
    visit admin_root_path
    click_on "Users"

    expect(current_path).to eq(admin_users_path)
  end

  scenario "and sees list of users" do
    user = create(:user)

    sign_in create(:user, :admin)
    visit admin_users_path

    expect(page).to have_content(user.email)
  end

  scenario "and chooses to create a new user" do
    sign_in create(:user, :admin)
    visit admin_users_path
    click_on "Add user"

    expect(current_path).to eq(new_admin_user_path)
  end

  scenario "and chooses to edit a user" do
    user = create(:user)

    sign_in create(:user, :admin)
    visit admin_users_path
    within "#user_#{user.to_param}" do
      find(".manage-user").click
      click_on "Edit user"
    end

    expect(current_path).to eq(edit_admin_user_path(user))
  end

  scenario "and chooses to filter the list of users by all statuses" do
    active_user = create(:user, :active)
    deactivated_user = create(:user, :deactivated)

    sign_in create(:user, :admin)
    visit admin_users_path
    click_on "All"

    expect(page).to have_content(active_user.email)
    expect(page).to have_content(deactivated_user.email)
  end

  scenario "and chooses to filter the list of users by active status" do
    active_user = create(:user, :active)
    deactivated_user = create(:user, :deactivated)

    sign_in create(:user, :admin)
    visit admin_users_path
    click_on "Active"

    expect(page).to have_content(active_user.email)
    expect(page).not_to have_content(deactivated_user.email)
  end

  scenario "and chooses to filter the list of users by deactive status" do
    deactivated_user = create(:user, :deactivated)
    active_user = create(:user, :active)

    sign_in create(:user, :admin)
    visit admin_users_path
    click_on "Deactive"

    expect(page).to have_content(deactivated_user.email)
    expect(page).not_to have_content(active_user.email)
  end
end
