class Admin::Bookings::PaymentsController < Admin::ApplicationController
  def create
    @booking = find_booking
    @booking.paid!
    redirect_back(
      fallback_location: admin_bookings_path,
      flash: { success: "Booking was successfully marked as paid." }
    )
  end

  private

  def find_booking
    Booking.find(params[:booking_id])
  end
end
