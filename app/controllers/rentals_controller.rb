class RentalsController < ApplicationController
  def show
    @rental = find_rental
  end

  private

  def find_rental
    Rental.find(params[:id])
  end
end
