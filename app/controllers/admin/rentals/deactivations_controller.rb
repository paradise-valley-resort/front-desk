class Admin::Rentals::DeactivationsController < Admin::ApplicationController
  def create
    @rental = find_rental
    @rental.touch(:deactivated_at)
    redirect_back(
      fallback_location: admin_rentals_path,
      flash: { success: "Rental was successfully deactivated." }
    )
  end

  private

  def find_rental
    Rental.find(params[:rental_id])
  end
end
