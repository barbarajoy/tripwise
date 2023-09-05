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
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.planner_id = current_user.id
    @trip.tripper_id = current_user.id
    trip_params["destinations_attributes"].each_key do |dest_params|
      @destination = Destination.new(trip_params["destinations_attributes"][dest_params])
      @destination.trip = @trip
      @destination.save
    end

    if @trip.save!
      redirect_to planner_trips_path(@trip)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    i = 1
    destinations_params["destinations_attributes"].each do |_, destination_attr|
      destination = Destination.find_by(id: destination_attr["id"]) || Destination.new
      if destination_attr["_destroy"] == "1"
        destination.destroy
      else
        destination.title = destination_attr["title"]
        destination.address = destination_attr["address"]
        destination.description = destination_attr["description"]
        destination.save
        trip_dest = TripDestination.find_by(destination:, trip: @trip)
        if trip_dest
          trip_dest.update(position: i)
        else
          TripDestination.create(destination:, trip: @trip, position: i)
        end
        i += 1
      end
    end
    redirect_to planner_trip_path(@trip.id)
  end

  private

  def trip_params
    params.require(:trip).permit(:id, :title, :comment, :budget, :city, :style, :photo)
  end

  def destinations_params
    params.require(:trip).permit(destinations_attributes: %i[title address description longitude id _destroy])
  end
end
