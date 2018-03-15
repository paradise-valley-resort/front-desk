class Admin::Bookings::PaidsController < Admin::ApplicationController
  def index
    @bookings = Booking.includes(:rental).paid
    if params[:sort] == "guest_name_asc"
      @bookings = @bookings.order(guest_name: :asc)
    elsif params[:sort] == "guest_name_desc"
      @bookings = @bookings.order(guest_name: :desc)
    elsif params[:sort] == "date_asc"
      @bookings = @bookings.order(starts_at: :asc, ends_at: :asc)
    elsif params[:sort] == "date_desc"
      @bookings = @bookings.order(starts_at: :desc, ends_at: :desc)
    else
      @bookings = @bookings.ordered
    end
    @bookings = @bookings.page(params[:page])
    render "admin/bookings/index"
  end
end
