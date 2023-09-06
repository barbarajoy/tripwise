class Planner::TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.planner_id = current_user.id
    @trip.tripper_id = current_user.id
    i = 1
    destinations_params["destinations_attributes"].each do |_, dest_params|
      destination = Destination.new(
        title: dest_params["title"],
        address: dest_params["address"],
        description: dest_params["description"]
      )
      destination.save
      TripDestination.create(destination:, trip: @trip, position: i)
      i += 1
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

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to planner_trips_path, status: :see_other
  end

  private

  def trip_params
    params.require(:trip).permit(:id, :title, :comment, :budget, :city, :style, :photo)
  end

  def destinations_params
    params.require(:trip).permit(destinations_attributes: %i[title address description longitude id _destroy])
  end
end
