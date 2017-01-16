class Admin::RentalsController < Admin::ApplicationController
  def new
    @rental = build_rental
  end

  def create
    @rental = build_rental(rental_params)
    if @rental.save
      redirect_to admin_rentals_path,
        flash: { success: "Rental was successfully created." }
    else
      render :new
    end
  end

  private

  def build_rental(rental_params = {})
    Rental.new(rental_params)
  end

  def rental_params
    params.require(:rental).permit(:name, :description)
  end
end
