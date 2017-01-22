require "rails_helper"

feature "Guest searches rentals" do
  scenario "with invalid attributes and sees error message" do
    visit rentals_search_path
    fill_in "Check In", with: ""
    fill_in "Check Out", with: 3.days.from_now
    click_on "Check availability"

    expect(page).to have_content("Check In can't be blank")
  end

  scenario "and sees list of rentals" do
    rental = create(:rental)

    visit rentals_search_path
    fill_in "Check In", with: 1.day.from_now
    fill_in "Check Out", with: 3.days.from_now
    click_on "Check availability"

    expect(page).to have_content(rental.name)
  end

  scenario "and sees blankslate when no rentals are available" do
    rental = create(:rental, :deactivated)

    visit rentals_search_path
    fill_in "Check In", with: 1.day.from_now
    fill_in "Check Out", with: 3.days.from_now
    click_on "Check availability"

    expect(page).to have_content(
      "Sorry, there are no rentals available during those dates"
    )
  end

  scenario "and selects a rental" do
    rental = create(:rental)

    visit rentals_search_path
    fill_in "Check In", with: 1.day.from_now
    fill_in "Check Out", with: 3.days.from_now
    click_on "Check availability"
    page.find(:css, "a[href='/rentals/#{rental.to_param}']").click

    expect(current_path).to eq(rental_path(rental))
  end
end
