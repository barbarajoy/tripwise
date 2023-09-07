class My::DestinationsController < ApplicationController


  def update
    @trip = Trip.find(params[:id])
    @destination = Destination.find(params[:destination][:id])
    if @destination.update!(
        title: params[:destination][:title],
        description: params[:destination][:description],
        latitude: params[:destination][:latitude],
        longitude: params[:destination][:longitude]
      )
      redirect_to my_trips_path(@trip.id)
    else
      raise
    end

  end

  private

  def trip_params
    params.require(:destination).permit(:id)
  end

end
