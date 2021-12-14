class AdminController < ApplicationController

  def home
    @admin = Admin.first
    @trips_obj = Trip.all
    @trips = []
    @trips_obj.each do |trip|
      @trips.push(trip)
    end
  end

end
