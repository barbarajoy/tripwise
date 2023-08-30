class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @min_budget = params[:min_budget].to_i
    @max_budget = params[:max_budget].to_i

    @trips = Trip.where(budget: @min_budget..@max_budget)
    render partial: 'trip', collection: @trips, locals: { show_budget: true }
  end
end
