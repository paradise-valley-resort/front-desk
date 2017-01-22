require "rails_helper"

feature "User marks booking as paid" do
  scenario "and sees success message" do
    booking = create(:booking, :approved)

    sign_in create(:user)
    visit admin_bookings_path
    within "#booking_#{booking.to_param}" do
      find(".manage-booking").click
      click_on "Mark booking as paid"
    end

    expect(page).to have_content("Booking was successfully marked as paid")
  end
end
