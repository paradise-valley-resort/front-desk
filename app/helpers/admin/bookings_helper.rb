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
end
