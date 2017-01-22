class Admin::Bookings::PendingsController < Admin::ApplicationController
  def index
    @bookings = Booking.pending.ordered.page(params[:page])
    render "admin/bookings/index"
  end
end
