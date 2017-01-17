class Admin::Rentals::ReactivationsController < Admin::ApplicationController
  def create
    @rental = find_rental
    @rental.update_attributes(deactivated_at: nil)
    redirect_back(
      fallback_location: admin_rentals_path,
      flash: { success: "Rental was successfully reactivated." }
    )
  end

  private

  def find_rental
    Rental.find(params[:rental_id])
  end
end
