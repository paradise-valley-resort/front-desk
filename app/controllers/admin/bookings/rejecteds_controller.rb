class Admin::Bookings::RejectedsController < Admin::ApplicationController
  def index
    @bookings = Booking.rejected.ordered.page(params[:page])
    render "admin/bookings/index"
  end
end
