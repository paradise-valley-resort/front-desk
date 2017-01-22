class Admin::Bookings::CancellationsController < Admin::ApplicationController
  def create
    @booking = find_booking
    @booking.cancelled!
    redirect_back(
      fallback_location: admin_bookings_path,
      flash: { success: "Booking was successfully cancelled." }
    )
  end

  private

  def find_booking
    Booking.find(params[:booking_id])
  end
end
