class BookingMailer < ApplicationMailer
  def request_confirmation(booking)
    @booking = booking

    mail(
      to: @booking.guest_email,
      subject: "Booking Request Confirmation - #{@booking.request_id}"
    )
  end

  def request_notification(booking)
    @booking = booking

    mail(
      to: "pv_resort@yahoo.com",
      subject: "New Booking Request Notification - #{@booking.request_id}"
    )
  end

  def approval_notification(booking)
    @booking = booking

    mail(
      to: @booking.guest_email,
      subject: "Booking Request Approved - #{@booking.request_id}"
    )
  end
end
