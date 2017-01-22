class Rentals::SearchesController < ApplicationController
  def show
    @search = RentalSearch.new(search_params)
    @search.validate if params[:commit].present?
  end

  private

  def search_params
    permitted_params.fetch(:rental_search, {})
  end

  def permitted_params
    params.permit(:commit, :utf8, rental_search: [:starts_at, :ends_at])
  end
end
