class Admin::CalendarsController < Admin::ApplicationController
  def show
    @calendar = Calendar.new(start_date, end_date)
    respond_to do |format|
      format.html
      format.json { render json: @calendar.bookings }
    end
  end

  private

  def end_date
    params[:end_date]
  end

  def start_date
    params[:start_date]
  end
end
