require "rails_helper"

feature "User views rentals" do
  scenario "is redirected away if not signed in" do
    visit admin_rentals_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "successfully" do
    sign_in create(:user)
    visit admin_rentals_path

    expect(current_path).to eq(admin_rentals_path)
  end

  scenario "by navigating from site header" do
    sign_in create(:user)
    visit authenticated_admin_root_path
    click_on "Rentals"

    expect(current_path).to eq(admin_rentals_path)
  end

  scenario "and sees list of rentals" do
    rental = create(:rental)

    sign_in create(:user)
    visit admin_rentals_path

    expect(page).to have_content(rental.name)
  end

  scenario "and chooses to create a new rental" do
    sign_in create(:user)
    visit admin_rentals_path
    click_on "Add rental"

    expect(current_path).to eq(new_admin_rental_path)
  end

  scenario "and chooses to edit a rental" do
    rental = create(:rental)

    sign_in create(:user)
    visit admin_rentals_path
    within "#rental_#{rental.to_param}" do
      find(".manage-rental").click
      click_on "Edit rental"
    end

    expect(current_path).to eq(edit_admin_rental_path(rental))
  end

  scenario "and chooses to filter the list of rentals by all statuses" do
    active_rental = create(:rental, :active, name: "Active Rental")
    deactivated_rental = create(:rental, :deactivated, name: "Deactivated Rental")

    sign_in create(:user)
    visit admin_rentals_path
    click_on "All"

    expect(page).to have_content(active_rental.name)
    expect(page).to have_content(deactivated_rental.name)
  end

  scenario "and chooses to filter the list of rentals by active status" do
    active_rental = create(:rental, :active, name: "Active Rental")
    deactivated_rental = create(:rental, :deactivated, name: "Deactivated Rental")

    sign_in create(:user)
    visit admin_rentals_path
    click_on "Active"

    expect(page).to have_content(active_rental.name)
    expect(page).not_to have_content(deactivated_rental.name)
  end

  scenario "and chooses to filter the list of rentals by deactive status" do
    deactivated_rental = create(:rental, :deactivated, name: "Deactivated Rental")
    active_rental = create(:rental, :active, name: "Active Rental")

    sign_in create(:user)
    visit admin_rentals_path
    click_on "Deactive"

    expect(page).to have_content(deactivated_rental.name)
    expect(page).not_to have_content(active_rental.name)
  end
end
