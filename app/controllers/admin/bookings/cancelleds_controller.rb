class Admin::Bookings::CancelledsController < Admin::ApplicationController
  def index
    if params[:sort] == "guest_name_asc"
      @bookings = Booking.cancelled.order(guest_name: :asc).page(params[:page])
    elsif params[:sort] == "guest_name_desc"
      @bookings = Booking.cancelled.order(guest_name: :desc).page(params[:page])
    elsif params[:sort] == "date_asc"
      @bookings = Booking.cancelled.order(starts_at: :asc, ends_at: :asc).page(params[:page])
    elsif params[:sort] == "date_desc"
      @bookings = Booking.cancelled.order(starts_at: :desc, ends_at: :desc).page(params[:page])
    else
      @bookings = Booking.cancelled.ordered.page(params[:page])
    end
    render "admin/bookings/index"
  end
end
