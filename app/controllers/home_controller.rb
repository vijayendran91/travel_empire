class HomeController < ApplicationController
  require_relative "../platform/trip_application" 
  include TripApplication
  
  def index
    @trip = Trip.new
  end

  def submit_trip
    params=get_trip_params()   
    perbus = params[:perbus]
    if(perbus.to_sym == Trip::PERSONAL)
    
    else
    
    end
    @trip = Trip.new(params)
    @trip.save
    CustomerMailer.with(:trip=>@trip).cab_booked.deliver_now
    redirect_to root_path
  end


  private
  
  def get_trip_params()
    params[:trip].permit(:perbus, :tot, :adult, :chldrn, :pul, :pua, :put, :drl,:dra,:drt, :fname, :lname, :phone, :email, :gst, :gst_lg_nm, :gst_full_addr, :tick, :photoproof1, :photoproof2)
  end

end
