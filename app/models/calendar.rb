class Calendar
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def bookings
    @bookings ||= Booking.includes(:rental).
      not_cancelled.
      not_rejected.
      between(start_date, end_date)
  end

  private

  attr_reader :start_date, :end_date
end
