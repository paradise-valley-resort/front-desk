class BookingMailer < ApplicationMailer
  def request_confirmation(booking)
    @booking = booking

    mail(
      to: @booking.guest_email,
      subject: "Booking Request Confirmation - #{@booking.request_id}"
    )
  end
end
