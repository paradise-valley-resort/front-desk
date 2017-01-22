module Admin::BookingsHelper
  def guest_contact_info_popover(booking)
    content_tag(:span) do
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
    end
  end

  private

  def booking_approved_status_label(booking)
    content_tag(:span, class: "label label-primary") do
      booking.status.capitalize
    end
  end

  def booking_pending_status_label(booking)
    content_tag(:span, class: "label label-default") do
      booking.status.capitalize
    end
  end

  def booking_rejected_status_label(booking)
    content_tag(:span, class: "label label-danger") do
      booking.status.capitalize
    end
  end
end
