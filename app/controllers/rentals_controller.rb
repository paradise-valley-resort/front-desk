class RentalsController < ApplicationController
  def show
    @rental = find_rental
    @starts_at = params[:starts_at] if params[:starts_at]
    @ends_at = params[:ends_at] if params[:ends_at]
  end

  private

  def find_rental
    Rental.find(params[:id])
  end
end
