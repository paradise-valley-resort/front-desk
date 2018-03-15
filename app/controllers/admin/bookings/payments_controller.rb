class Admin::Bookings::PaymentsController < Admin::ApplicationController
  def create
    @booking = find_booking
    payment_type = params.fetch(:payment_type, false)
    if payment_types.include?(payment_type)
      if payment_type == "deposit_paid"
        @booking.deposit_paid!
      elsif payment_type == "paid_in_full"
        @booking.paid_in_full!
      end
      redirect_back(
        fallback_location: admin_bookings_path,
        flash: { success: "Booking was successfully marked as #{payment_type.humanize.titleize}." }
      )
    else
      redirect_back(fallback_location: admin_bookings_path)
    end

  end

  private

  def find_booking
    Booking.find(params[:booking_id])
  end

  def payment_types
    %w(deposit_paid paid_in_full)
  end
end
