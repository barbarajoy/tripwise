class My::TripsController < ApplicationController
  # skip_before_action :verify_csrf_token
  def new
    raise
  end

  def create
    @trip = Trip.find_by(trip_id: params[:trip_id], tripper_id: current_user)
    if @trip.nil?
      @old_trip = Trip.find(params[:trip_id])
      copied_trip = @old_trip.dup
      copied_trip.trip_id = @old_trip.id
      copied_trip.trip_destinations = @old_trip.trip_destinations
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

  def update
    @trip = Trip.find(params["id"])
    @trip_destinations = @trip.trip_destinations.order(:position)

    trip_destination1 = @trip_destinations.find_by(position: params["oldIndex"].to_i + 1)
    trip_destination1.position = params["newIndex"] + 1

    if params["newIndex"].to_i > params["oldIndex"].to_i
      (params["oldIndex"].to_i..params["newIndex"].to_i).each do |a|
        trip_destination2 = @trip_destinations.find_by(position: a + 1)
        trip_destination2.position = a
        trip_destination2.save!
      end
    else
      (params["newIndex"].to_i..params["oldIndex"].to_i - 1).each do |a|
        trip_destination2 = @trip_destinations.find_by(position: a + 1)
        trip_destination2.position = a + 2
        trip_destination2.save!
      end
    end
    trip_destination1.save!
  end

  def show
    @trip = Trip.find(params[:id])
    @trips = Trip.all
    @new_message = Message.new

  end

  def custom_validate
    @trip = Trip.find(params[:id])
    @trip.update(custom_validate: true)
    redirect_to planner_trip_path(@trip.id)
  end

  def download_pdf
    send_file(
      "#{Rails.root}/public/image.pdf",
      filename: "coco.pdf",
      type: "application/pdf"
    )
  end

  # private

  # def trip_params
  #   params.require(:trip).permit(:id)
  # end
end
