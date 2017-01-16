require "rails_helper"

feature "Admin deactivates user" do
  scenario "is unable to deactivate himself" do
    admin = create(:user, :admin)

    sign_in admin
    visit admin_users_path
    within "#user_#{admin.to_param}" do
      expect(page).not_to have_button("Deactivate user")
    end
  end

  scenario "and is presented with confirmation dialog", js: true do
    user = create(:user, :active)

    sign_in create(:user, :admin)
    visit admin_users_path
    confirm_message = accept_confirm do
      within "#user_#{user.to_param}" do
        find(".manage-user").click
        click_on "Deactivate user"
      end
    end

    expect(confirm_message).to eq(
      "Are you sure you want to deactivate this user?"
    )
  end

  scenario "and sees success message", js: true do
    user = create(:user, :active)

    sign_in create(:user, :admin)
    visit admin_users_path
    accept_confirm do
      within "#user_#{user.to_param}" do
        find(".manage-user").click
        click_on "Deactivate user"
      end
    end

    expect(page).to have_content("User was successfully deactivated")
  end
end
