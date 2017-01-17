require "rails_helper"

feature "User reactivates rental" do
  scenario "and sees success message" do
    rental = create(:rental, :deactivated)

    sign_in create(:user)
    visit admin_rentals_path
    within "#rental_#{rental.to_param}" do
      find(".manage-rental").click
      click_on "Reactivate rental"
    end

    expect(page).to have_content("Rental was successfully reactivated")
  end
end
