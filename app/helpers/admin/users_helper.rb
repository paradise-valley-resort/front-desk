module Admin::UsersHelper
  def user_password_hint(user)
    if user.persisted?
      "Leave blank if you don't want to change it"
    else
      "Use at least #{user.class.password_length.min} characters" if user.class.password_length.min
    end
  end

  def users_status_filter_button_group
    content_tag :div, class: "btn-group", role: "group" do
      concat(users_status_filter_all_button)
      concat(users_status_filter_active_button)
      concat(users_status_filter_deactive_button)
    end
  end

  private

  def users_status_filter_active_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "actives"
    link_to "Active", admin_users_actives_path, class: klass
  end

  def users_status_filter_all_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "users"
    link_to "All", admin_users_path, class: klass
  end

  def users_status_filter_deactive_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "deactives"
    link_to "Deactive", admin_users_deactives_path, class: klass
  end
end
