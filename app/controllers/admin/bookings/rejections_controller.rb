class Admin::Bookings::RejectionsController < Admin::ApplicationController
  def create
    @booking = find_booking
    @booking.rejected!
    redirect_back(
      fallback_location: admin_bookings_path,
      flash: { success: "Booking was successfully rejected." }
    )
  end

  private

  def find_booking
    Booking.find(params[:booking_id])
  end
end
