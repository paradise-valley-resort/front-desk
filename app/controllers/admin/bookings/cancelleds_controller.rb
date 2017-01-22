class Admin::Bookings::CancelledsController < Admin::ApplicationController
  def index
    @bookings = Booking.cancelled.ordered.page(params[:page])
    render "admin/bookings/index"
  end
end
