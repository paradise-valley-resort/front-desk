module FormsHelper
  def error_notification(form, options = {})
    resource = form.object
    form.error_notification(
      message: error_notification_message(resource, options)
    )
  end

  private

  def error_notification_message(resource, options = {})
    context = resource.persisted? ? "updating" : "creating"
    resource_display_name = options.fetch(
      :resource_display_name,
      resource_default_display_name(resource)
    )
    "There were problems #{context} the #{resource_display_name}."
  end

  def resource_default_display_name(resource)
    resource.class.name.downcase
  end
end
