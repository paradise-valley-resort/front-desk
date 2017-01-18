module Admin::MembersHelper
  def member_contact_info_popover(member)
    content_tag(:span) do
      concat("#{content_tag(:strong, "Address")}")
      concat("#{tag(:br)}")
      concat("#{member.address_1}")
      concat("#{tag(:br)}")
      if member.address_2.present?
        concat("#{member.address_2}")
        concat("#{tag(:br)}")
      end
      concat("#{member.city}, #{member.state} #{member.zip_code}")
      concat("#{tag(:br)}")
      concat("#{tag(:br)}")
      concat("#{content_tag(:strong, "Phone")}")
      concat("#{tag(:br)}")
      if member.phone.present?
        concat("#{member.phone}")
      else
        concat("No phone provided")
      end
      concat("#{tag(:br)}")
      concat("#{tag(:br)}")
      concat("#{content_tag(:strong, "Email")}")
      concat("#{tag(:br)}")
      if member.email.present?
        concat("#{mail_to(member.email)}")
      else
        concat("No email provided")
      end
    end
  end
end
