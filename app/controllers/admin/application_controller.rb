class Admin::ApplicationController < ApplicationController
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  layout "admin"

  before_action :authenticate_user!

  private

  def user_not_authorized
    redirect_back(
      fallback_location: admin_root_path,
      alert: "You are not authorized to perform this action."
    )
  end
end
