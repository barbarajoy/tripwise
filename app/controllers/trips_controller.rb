class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @trips = Trip.all
    if params.dig(:filter, :style)
      @trips = @trips.where(style: params[:filter][:style])
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end
end
