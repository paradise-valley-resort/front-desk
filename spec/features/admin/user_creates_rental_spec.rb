require "rails_helper"

feature "User creates rental" do
  scenario "is redirected away if not signed in" do
    visit new_admin_rental_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "with invalid attributes and sees error message" do
    sign_in create(:user)
    visit new_admin_rental_path
    fill_out_rental_form(name: "")

    expect(page).to have_content("There were problems creating the rental")
    expect(page).to have_content("Name can't be blank")
  end

  scenario "with valid attributes and sees success message" do
    sign_in create(:user)
    visit new_admin_rental_path
    fill_out_rental_form

    expect(page).to have_content("Rental was successfully created")
  end

  def fill_out_rental_form(rental_attributes = {})
    rental = build(:rental, {}.merge(rental_attributes))
    fill_in "Name", with: rental.name
    click_on "Create rental"
  end
end
