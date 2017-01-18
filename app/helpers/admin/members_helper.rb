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

  def members_status_filter_button_group
    content_tag :div, class: "btn-group", role: "group" do
      concat(members_status_filter_all_button)
      concat(members_status_filter_active_button)
      concat(members_status_filter_deactive_button)
    end
  end

  private

  def members_status_filter_active_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "actives"
    link_to "Active", admin_members_actives_path, class: klass
  end

  def members_status_filter_all_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "members"
    link_to "All", admin_members_path, class: klass
  end

  def members_status_filter_deactive_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "deactives"
    link_to "Deactive", admin_members_deactives_path, class: klass
  end
end
