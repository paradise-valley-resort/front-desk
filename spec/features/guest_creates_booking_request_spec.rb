require "rails_helper"

feature "Guest creates booking request" do
  scenario "with invalid attributes and sees error message" do
    rental = create(:rental)

    visit new_rental_booking_request_path(rental)
    fill_out_booking_request_form(starts_at: nil)

    expect(page).to have_content("There were problems creating the booking request")
    expect(page).to have_content("Check In can't be blank")
  end

  scenario "with valid attributes and sees success message" do
    rental = create(:rental)

    visit new_rental_booking_request_path(rental)
    fill_out_booking_request_form

    expect(page).to have_content("Booking request was successfully created")
  end

  def fill_out_booking_request_form(booking_attributes = {})
    booking = build(:booking, {}.merge(booking_attributes))
    fill_in "Check In", with: booking.starts_at.strftime("%Y-%m-%d") if booking.starts_at.present?
    fill_in "Check Out", with: booking.ends_at.strftime("%Y-%m-%d") if booking.ends_at.present?
    click_on "Submit booking request"
  end
end
