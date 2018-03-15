module Admin::BookingsHelper
  def guest_contact_info_popover(booking)
    content_tag(:span) do
      concat("#{content_tag(:strong, "Request #")}")
      concat("#{tag(:br)}")
      concat("#{booking.request_id}")
      concat("#{tag(:br)}")
      concat("#{tag(:br)}")
      concat("#{content_tag(:strong, "Membership #")}")
      concat("#{tag(:br)}")
      if booking.guest_membership_id.present?
        concat("#{booking.guest_membership_id}")
      else
        concat("Membership number not provided")
      end
      concat("#{tag(:br)}")
      concat("#{tag(:br)}")
      concat("#{content_tag(:strong, "Email")}")
      concat("#{tag(:br)}")
      concat("#{mail_to(booking.guest_email)}")
    end
  end

  def booking_status_label(booking)
    case booking.status
    when "pending"
      booking_pending_status_label(booking)
    when "approved"
      booking_approved_status_label(booking)
    when "rejected"
      booking_rejected_status_label(booking)
    when "paid_in_full"
      booking_paid_status_label(booking)
    when "deposit_paid"
      booking_partially_paid_status_label(booking)
    when "cancelled"
      booking_cancelled_status_label(booking)
    end
  end

  def bookings_status_filter_button_group
    content_tag :div, class: "btn-group", role: "group" do
      concat(bookings_status_filter_all_button)
      concat(bookings_status_filter_pending_button)
      concat(bookings_status_filter_approved_button)
      concat(bookings_status_filter_paid_button)
      concat(bookings_status_filter_cancelled_button)
      concat(bookings_status_filter_rejected_button)
    end
  end

  private

  def booking_approved_status_label(booking)
    content_tag(:span, class: "label label-primary") do
      booking.status.humanize.titleize
    end
  end

  def booking_cancelled_status_label(booking)
    content_tag(:span, class: "label label-danger") do
      booking.status.humanize.titleize
    end
  end

  def booking_paid_status_label(booking)
    content_tag(:span, class: "label label-success") do
      booking.status.humanize.titleize
    end
  end

  def booking_partially_paid_status_label(booking)
    content_tag(:span, class: "label label-success") do
      booking.status.humanize.titleize
    end
  end

  def booking_pending_status_label(booking)
    content_tag(:span, class: "label label-default") do
      booking.status.humanize.titleize
    end
  end

  def booking_rejected_status_label(booking)
    content_tag(:span, class: "label label-danger") do
      booking.status.humanize.titleize
    end
  end

  def bookings_status_filter_all_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "bookings"
    link_to "All", admin_bookings_path, class: klass
  end

  def bookings_status_filter_approved_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "approveds"
    link_to "Approved", admin_bookings_approveds_path, class: klass
  end

  def bookings_status_filter_cancelled_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "cancelleds"
    link_to "Cancelled", admin_bookings_cancelleds_path, class: klass
  end

  def bookings_status_filter_paid_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "paids"
    link_to "Paid", admin_bookings_paids_path, class: klass
  end

  def bookings_status_filter_pending_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "pendings"
    link_to "Pending", admin_bookings_pendings_path, class: klass
  end

  def bookings_status_filter_rejected_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "rejecteds"
    link_to "Rejected", admin_bookings_rejecteds_path, class: klass
  end
end
