class Admin::Bookings::ApprovedsController < Admin::ApplicationController
  def index
    @bookings = Booking.approved.ordered.page(params[:page])
    render "admin/bookings/index"
  end
end
