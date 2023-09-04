class Planner::TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
  end

  # def create
  #   @trip = Trip.find(params[:trip_id])
  #   if @trip.trip.nil?
  #     copied_trip = @trip.dup
  #     copied_trip.trip_id = @trip.id
  #     copied_trip.tripper = current_user
  #     if copied_trip.save
  #       redirect_to my_trip_path(copied_trip)
  #     else
  #       raise
  #     end
  #   else
  #     redirect_to my_trip_path(@trip)
  #   end
  # end

  def new
    @trip = Trip.new
    #@destination = Destination.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    #@destination = Destination.new(destination_params)
    #@destination.user_id = current_user.id
    if @trip.save!
      redirect_to planner_trips_path(@trip)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.require(:trip).permit(trip_attributes: [:id, :title, :comment, :budget, :city, :style, :photo],
                                 destination_attributes: [:title])
  end
end
