require "rails_helper"

feature "Guest creates booking request" do
  scenario "with invalid attributes and sees error message" do
    rental = create(:rental)

    fill_out_rental_search_form
    select_rental(rental.to_param)
    fill_out_booking_request_form(guest_name: nil)

    expect(page).to have_content("There were problems creating the booking request")
    expect(page).to have_content("Name can't be blank")
  end

  scenario "with valid attributes and sees success message" do
    rental = create(:rental)

    fill_out_rental_search_form
    select_rental(rental.to_param)
    fill_out_booking_request_form

    expect(page).to have_content("Booking request was successfully created")
  end

  scenario "and rental becomes no longer available" do
    rental = create(:rental)

    fill_out_rental_search_form
    select_rental(rental.to_param)
    rental.touch(:deactivated_at)
    fill_out_booking_request_form

    expect(current_path).to eq(rentals_search_path)
    expect(page).to have_content("Sorry, this rental is no longer available")
  end

  def fill_out_booking_request_form(booking_attributes = {})
    booking = build(:booking, {}.merge(booking_attributes))
    fill_in "Full Name", with: booking.guest_name
    fill_in "Email", with: booking.guest_email
    click_on "Submit booking request"
  end

  def fill_out_rental_search_form
    visit rentals_search_path
    fill_in "Check In", with: 1.day.from_now
    fill_in "Check Out", with: 3.days.from_now
    click_on "Check availability"
  end

  def select_rental(rental_id)
    within "#rental_#{rental_id}" do
      click_on "Request to book"
    end
  end
end
