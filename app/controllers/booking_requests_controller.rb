class BookingRequestsController < ApplicationController
  def new
    @booking = build_booking
    set_booking_starts_at_and_ends_at
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
    @booking = find_booking
  end

  private

  def booking_params
    params.require(:booking).permit(
      :guest_email,
      :guest_membership_id,
      :guest_name,
      :starts_at,
      :ends_at
    )
  end

  def build_booking(booking_params = {})
    rental = find_rental
    rental.bookings.build(booking_params)
  end

  def find_booking
    Booking.find(params[:id])
  end

  def find_rental
    Rental.find(params[:rental_id])
  end

  def set_booking_ends_at
    @booking.ends_at = params[:ends_at] if params[:ends_at]
  end

  def set_booking_starts_at
    @booking.starts_at = params[:starts_at] if params[:starts_at]
  end

  def set_booking_starts_at_and_ends_at
    set_booking_starts_at
    set_booking_ends_at
  end
end
