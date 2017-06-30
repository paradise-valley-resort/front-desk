class Admin::Bookings::ApprovalsController < Admin::ApplicationController
  def create
    @booking = find_booking

    unless @booking.rental.available_between?(@booking.starts_at, @booking.ends_at)
      flash[:error] = "Sorry, this booking cannot be approved because the rental is no longer available."
      redirect_back(fallback_location: admin_bookings_path) and return
    end

    @booking.approved!
    BookingMailer.approval_notification(@booking).deliver_now
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
