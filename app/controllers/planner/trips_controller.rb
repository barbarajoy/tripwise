class Planner::TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def create
    @trip = Trip.find(params[:trip_id])
    if @trip.trip.nil?
      copied_trip = @trip.dup
      copied_trip.trip_id = @trip.id
      copied_trip.tripper = current_user
      if copied_trip.save
        redirect_to my_trip_path(copied_trip)
      else
        raise
      end
    else
      redirect_to my_trip_path(@trip)
    end
  end

end
