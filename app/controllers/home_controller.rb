class HomeController < ApplicationController
  def index
    @trip = Trip.new
  end

  def submit_trip
    permitted_param=params[:trip].permit(:perbus, :tot, :adult, :chldrn, :pul, :pua, :put, :drl,:dra,:drt, :fname, :lname, :phone, :email, :gst)
    @trip = Trip.new(permitted_param)
    @trip.save
    redirect_to root_path
  end
end
