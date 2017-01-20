class BookingRequestsController < ApplicationController
  def new
    @booking = build_booking
  end

  def create
    @booking = build_booking(booking_params)
    if @booking.save
      redirect_to booking_request_path(@booking),
        flash: { success: "Booking request was successfully created." }
    else
      render :new
    end
  end

  def show
  end

  private

  def booking_params
    params.require(:booking).permit(:starts_at, :ends_at)
  end

  def build_booking(booking_params = {})
    rental = find_rental
    rental.bookings.build(booking_params)
  end

  def find_rental
    Rental.find(params[:rental_id])
  end
end
