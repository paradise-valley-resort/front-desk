# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview
  def request_confirmation
    rental = Rental.new(name: "Cabin 1")
    booking = rental.bookings.new(
      guest_name: "John Doe",
      guest_email: "john.doe@example.com",
      request_id: "PVR123456789"
    )

    BookingMailer.request_confirmation(booking)
  end
end
