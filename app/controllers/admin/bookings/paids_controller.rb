class Admin::Bookings::PaidsController < Admin::ApplicationController
  def index
    @bookings = Booking.paid.ordered.page(params[:page])
    render "admin/bookings/index"
  end
end
