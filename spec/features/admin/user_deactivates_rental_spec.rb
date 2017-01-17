require "rails_helper"

feature "User deactivates rental" do
  scenario "and is presented with confirmation dialog", js: true do
    rental = create(:rental, :active)

    sign_in create(:user)
    visit admin_rentals_path
    confirm_message = accept_confirm do
      within "#rental_#{rental.to_param}" do
        find(".manage-rental").click
        click_on "Deactivate rental"
      end
    end

    expect(confirm_message).to eq(
      "Are you sure you want to deactivate this rental?"
    )
  end

  scenario "and sees success message", js: true do
    rental = create(:rental, :active)

    sign_in create(:user)
    visit admin_rentals_path
    accept_confirm do
      within "#rental_#{rental.to_param}" do
        find(".manage-rental").click
        click_on "Deactivate rental"
      end
    end

    expect(page).to have_content("Rental was successfully deactivated")
  end
end
