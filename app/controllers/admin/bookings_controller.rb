class Admin::BookingsController < Admin::ApplicationController
  def index
    @bookings = Booking.ordered.page(params[:page])
  end
end
