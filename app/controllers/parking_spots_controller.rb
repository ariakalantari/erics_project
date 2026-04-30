class ParkingSpotsController < ApplicationController
  def show
    @spot = ParkingSpot.includes(:parking_area, :charger).find(params[:id])
  end

  def update
    @spot = ParkingSpot.includes(:parking_area, :charger).find(params[:id])
    @spot.update!(parking_spot_params)
    render :show
  end

  private

  def parking_spot_params
    params.require(:parking_spot).permit(:status)
  end
end
