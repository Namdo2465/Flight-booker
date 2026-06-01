class FlightsController < ApplicationController
  def index
    @airports = Airport.all
    @dates = Flight.pluck(:start_datetime).map(&:to_date).uniq.sort
    @passenger_options = [1, 2, 3, 4]

    if search_params_present?
      @flights = Flight.where(
        departure_airport_id: params[:departure_airport_id],
        arrival_airport_id: params[:arrival_airport_id],
        start_datetime: Date.parse(params[:date]).all_day
      )
    else
      @flights = []
    end
  end

  private

  def search_params_present?
    params[:departure_airport_id].present? &&
      params[:arrival_airport_id].present? &&
      params[:date].present?
  end
end