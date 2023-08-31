class TripsController < ApplicationController
  def index
    @trips = Trip.all
    if params[:query].present?
      @trips = @trips.where("title ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end
end
