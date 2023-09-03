class My::TripsController < ApplicationController
  def new
    raise
  end

  def create
    raise
    # my
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
