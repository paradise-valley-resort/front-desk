require "rails_helper"

feature "User cancels booking" do
  scenario "and is presented with confirmation dialog", js: true do
    booking = create(:booking, :approved)

    sign_in create(:user)
    visit admin_bookings_path
    confirm_message = accept_confirm do
      within "#booking_#{booking.to_param}" do
        find(".manage-booking").click
        click_on "Cancel booking"
      end
    end

    expect(confirm_message).to eq(
      "Are you sure you want to cancel this booking?"
    )
  end

  scenario "and sees success message" do
    booking = create(:booking, :approved)

    sign_in create(:user)
    visit admin_bookings_path
    within "#booking_#{booking.to_param}" do
      find(".manage-booking").click
      click_on "Cancel booking"
    end

    expect(page).to have_content("Booking was successfully cancelled")
  end
end
