class Admin::Members::DeactivesController < Admin::ApplicationController
  def index
    @members = Member.deactive.ordered.page(params[:page])
    render "admin/members/index"
  end
end
