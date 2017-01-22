require "rails_helper"

feature "User approves booking request" do
  scenario "and sees success message" do
    booking = create(:booking, :pending)

    sign_in create(:user)
    visit admin_bookings_path
    within "#booking_#{booking.to_param}" do
      find(".manage-booking").click
      click_on "Approve booking"
    end

    expect(page).to have_content("Booking was successfully approved.")
  end

  scenario "and rental becomes no longer available" do
    booking = create(:booking, :pending)
    booking.rental.touch(:deactivated_at)

    sign_in create(:user)
    visit admin_bookings_path
    within "#booking_#{booking.to_param}" do
      find(".manage-booking").click
      click_on "Approve booking"
    end

    expect(page).to have_content(
      "Sorry, this booking cannot be approved because the rental is no longer available"
    )
  end
end
