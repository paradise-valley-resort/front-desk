class Admin::Users::ActivesController < Admin::ApplicationController
  def index
    @users = User.active.ordered.page(params[:page])
    authorize @users
    render "admin/users/index"
  end
end
