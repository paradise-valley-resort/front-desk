class Admin::Rentals::ActivesController < Admin::ApplicationController
  def index
    @rentals = Rental.active.ordered.page(params[:page])
    render "admin/rentals/index"
  end
end
