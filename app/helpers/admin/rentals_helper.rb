module Admin::RentalsHelper
  def rentals_status_filter_button_group
    content_tag :div, class: "btn-group", role: "group" do
      concat(rentals_status_filter_all_button)
      concat(rentals_status_filter_active_button)
      concat(rentals_status_filter_deactive_button)
    end
  end

  private

  def rentals_status_filter_active_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "actives"
    link_to "Active", admin_rentals_actives_path, class: klass
  end

  def rentals_status_filter_all_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "rentals"
    link_to "All", admin_rentals_path, class: klass
  end

  def rentals_status_filter_deactive_button
    klass = "btn btn-default"
    klass = "#{klass} active" if controller_name == "deactives"
    link_to "Deactive", admin_rentals_deactives_path, class: klass
  end
end
