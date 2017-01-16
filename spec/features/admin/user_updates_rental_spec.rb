require "rails_helper"

feature "User updates rental" do
  scenario "is redirected away if not signed in" do
    rental = create(:rental)

    visit edit_admin_rental_path(rental)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "with invalid attributes and sees error message" do
    rental = create(:rental)

    sign_in create(:user)
    visit edit_admin_rental_path(rental)
    fill_in "Name", with: ""
    click_on "Update rental"

    expect(page).to have_content("There were problems updating the rental")
    within ".rental_name" do
      expect(page).to have_content("Name can't be blank")
    end
  end

  scenario "with valid attributes and sees success message" do
    rental = create(:rental)

    sign_in create(:user)
    visit edit_admin_rental_path(rental)
    fill_in "Name", with: "New Name"
    click_on "Update rental"

    expect(page).to have_content("Rental was successfully updated")
  end
end
