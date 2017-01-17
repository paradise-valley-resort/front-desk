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
    visit admin_root_path
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
end
