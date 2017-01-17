class Admin::Rentals::DeactivesController < Admin::ApplicationController
  def index
    @rentals = Rental.deactive.ordered.page(params[:page])
    render "admin/rentals/index"
  end
end
