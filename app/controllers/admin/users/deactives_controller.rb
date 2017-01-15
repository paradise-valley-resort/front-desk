class Admin::Users::DeactivesController < Admin::ApplicationController
  def index
    @users = User.deactive.ordered.page(params[:page])
    authorize @users
    render "admin/users/index"
  end
end
