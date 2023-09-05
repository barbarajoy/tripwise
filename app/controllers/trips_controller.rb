class TripsController < ApplicationController
  def index
    @trips = Trip.all
    # if params[:query].present?

    #   @trips = @trips.where("title ILIKE ?", "%#{params[:query]}%")
    # end
    if params[:filter].present?
      @trips = @trips.where("title ILIKE ?", "%#{params[:filter][:title]}%") if params[:filter][:title].present?
    end
    if params[:filter].present?
      @trips = @trips.where(style: params[:filter][:style]) unless params[:filter][:style] == [""]
    end
    @trips = @trips.select { |trip| trip.planner == trip.tripper }

  end

  def show
    @trip = Trip.find(params[:id])
    @new_trip = Trip.new
  end

  def new
    raise
  end

end
