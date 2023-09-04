class My::MessagesController < ApplicationController
  def create
    @trip = Trip.find(params[:trip_id])
    @message = Message.new(message_params)
    @message.trip = @trip
    @message.user = current_user
    if @message.save
      redirect_to my_trip_path(@trip)
    else
      @trip = Trip.find(params[:id])
      @trips = Trip.all
      @new_message = Message.new
      render "my/trips/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
