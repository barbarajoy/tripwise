class TripsController < ApplicationController
  def index
    @trips = Trip.all
    if params[:query].present?
      @trips = @trips.where("title ILIKE ?", "%#{params[:query]}%")
    end
    if params.dig(:filter, :style)
      @trips = @trips.where(style: params[:filter][:style])
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @new_trip = Trip.new
  end

  def new
    raise
  end
end
