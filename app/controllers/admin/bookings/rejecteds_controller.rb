class Admin::Bookings::RejectedsController < Admin::ApplicationController
  def index
    if params[:sort] == "guest_name_asc"
      @bookings = Booking.rejected.order(guest_name: :asc).page(params[:page])
    elsif params[:sort] == "guest_name_desc"
      @bookings = Booking.rejected.order(guest_name: :desc).page(params[:page])
    elsif params[:sort] == "date_asc"
      @bookings = Booking.rejected.order(starts_at: :asc, ends_at: :asc).page(params[:page])
    elsif params[:sort] == "date_desc"
      @bookings = Booking.rejected.order(starts_at: :desc, ends_at: :desc).page(params[:page])
    else
      @bookings = Booking.rejected.ordered.page(params[:page])
    end
    render "admin/bookings/index"
  end
end
