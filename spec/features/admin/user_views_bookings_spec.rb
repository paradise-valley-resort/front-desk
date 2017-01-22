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

  scenario "and chooses to create a new booking" do
    sign_in create(:user)
    visit admin_bookings_path
    click_on "Add booking"

    expect(current_path).to eq(rentals_search_path)
  end

  scenario "and chooses to filter the list of bookings by all statuses" do
    pending_booking = create(:booking, :pending)
    approved_booking = create(:booking, :approved)

    sign_in create(:user)
    visit admin_bookings_path
    click_on "All"

    expect(page).to have_content(pending_booking.request_id)
    expect(page).to have_content(approved_booking.request_id)
  end

  scenario "and chooses to filter the list of bookings by pending status" do
    pending_booking = create(:booking, :pending)
    approved_booking = create(:booking, :approved)

    sign_in create(:user)
    visit admin_bookings_path
    click_on "Pending"

    expect(page).to have_content(pending_booking.request_id)
    expect(page).not_to have_content(approved_booking.request_id)
  end

  scenario "and chooses to filter the list of bookings by approved status" do
    approved_booking = create(:booking, :approved)
    pending_booking = create(:booking, :pending)

    sign_in create(:user)
    visit admin_bookings_path
    click_on "Approved"

    expect(page).to have_content(approved_booking.request_id)
    expect(page).not_to have_content(pending_booking.request_id)
  end

  scenario "and chooses to filter the list of bookings by rejected status" do
    rejected_booking = create(:booking, :rejected)
    pending_booking = create(:booking, :pending)

    sign_in create(:user)
    visit admin_bookings_path
    click_on "Rejected"

    expect(page).to have_content(rejected_booking.request_id)
    expect(page).not_to have_content(pending_booking.request_id)
  end

  scenario "and chooses to filter the list of bookings by paid status" do
    paid_booking = create(:booking, :paid)
    pending_booking = create(:booking, :pending)

    sign_in create(:user)
    visit admin_bookings_path
    click_on "Paid"

    expect(page).to have_content(paid_booking.request_id)
    expect(page).not_to have_content(pending_booking.request_id)
  end
end
