class Admin::Bookings::ApprovalsController < Admin::ApplicationController
  def create
    @booking = find_booking
    @booking.approved!
    redirect_back(
      fallback_location: admin_bookings_path,
      flash: { success: "Booking was successfully approved." }
    )
  end

  private

  def find_booking
    Booking.find(params[:booking_id])
  end
end
