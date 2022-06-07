require_relative '../platform/trip_application'
class TripController < ApplicationController
  include TripApplication


  def status
    render "driver_module/status"
  end

end
