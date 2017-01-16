require "rails_helper"

feature "Admin demotes user" do
  scenario "is unable to demote himself" do
    admin = create(:user, :admin)

    sign_in admin
    visit admin_users_path
    within "#user_#{admin.to_param}" do
      expect(page).not_to have_button("Remove admin access")
    end
  end

  scenario "and is presented with confirmation dialog", js: true do
    user = create(:user, :admin)

    sign_in create(:user, :admin)
    visit admin_users_path
    confirm_message = accept_confirm do
      within "#user_#{user.to_param}" do
        find(".manage-user").click
        click_on "Remove admin access"
      end
    end

    expect(confirm_message).to eq(
      "Are you sure you want to remove this user's admin access?"
    )
  end

  scenario "and sees success message", js: true do
    user = create(:user, :admin)

    sign_in create(:user, :admin)
    visit admin_users_path
    accept_confirm do
      within "#user_#{user.to_param}" do
        find(".manage-user").click
        click_on "Remove admin access"
      end
    end

    expect(page).to have_content("Admin access was successfully removed")
  end
end
