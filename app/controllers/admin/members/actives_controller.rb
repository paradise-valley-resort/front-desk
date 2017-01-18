class Admin::Members::ActivesController < Admin::ApplicationController
  def index
    @members = Member.active.ordered.page(params[:page])
    render "admin/members/index"
  end
end
