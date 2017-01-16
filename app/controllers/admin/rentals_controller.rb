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

  def edit
    @rental = find_rental
  end

  def update
    @rental = find_rental
    if @rental.update_attributes(rental_params)
      redirect_to admin_rentals_path,
        flash: { success: "Rental was successfully updated." }
    else
      render :edit
    end
  end

  private

  def build_rental(rental_params = {})
    Rental.new(rental_params)
  end

  def find_rental
    Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:name, :description)
  end
end
