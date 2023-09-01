class My::TripsController < ApplicationController
  def new
    raise
  end

  def create
    @trip = Trip.find(params[:trip_id])
    if @trip.trip.nil?
      copied_trip = @trip.dup
      copied_trip.trip_id = @trip.id
      copied_trip.tripper = User.where.not(id: @trip.id).sample #current_user
      if copied_trip.save
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

    # sql_subquery = "name ILIKE :query OR breed ILIKE :query"
    # @trips = Trip.all.where(sql_subquery, query: "%#{params[:query]}%")
    @trips = Trip.all

    @interlocutor = @trip.planner
    # @interlocutor = @trip.tripper if current_user == @trip.planner

    @message = Message.new
  end

  # private

  # def trip_params
  #   params.require(:trip).permit(:id)
  # end
end
