class HomeController < ApplicationController
  def index
    @trip = Trip.new
  end

  def submit_trip
    redirect_to root_path
  end
end
