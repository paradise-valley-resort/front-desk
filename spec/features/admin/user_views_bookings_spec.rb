require "rails_helper"

feature "User views bookings" do
  scenario "is redirected away if not signed in" do
    visit admin_bookings_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario "successfully" do
    sign_in create(:user)
    visit admin_bookings_path

    expect(current_path).to eq(admin_bookings_path)
  end

  scenario "by navigating from site header" do
    sign_in create(:user)
    visit admin_root_path
    click_on "Bookings"

    expect(current_path).to eq(admin_bookings_path)
  end

  scenario "and sees list of bookings" do
    booking = create(:booking)

    sign_in create(:user)
    visit admin_bookings_path

    expect(page).to have_content(booking.request_id)
  end
end
