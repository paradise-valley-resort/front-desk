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
end
