class My::TripsController < ApplicationController
  def new
    raise
  end

  def create

    @trip = Trip.find_by(trip_id: params[:trip_id], tripper_id: current_user)
    if @trip.nil?
      @old_trip = Trip.find(params[:trip_id])
      copied_trip = @old_trip.dup
      copied_trip.trip_id = @old_trip.id
      copied_trip.destinations = @old_trip.destinations
      copied_trip.tripper = current_user
      if copied_trip.save
        @trip = Trip.find(copied_trip.id)
        redirect_to my_trip_path(copied_trip)
      else
        raise
      end
    else
      redirect_to my_trip_path(@trip)
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @trips = Trip.all
    @new_message = Message.new
  end

  # private

  # def trip_params
  #   params.require(:trip).permit(:id)
  # end
end
