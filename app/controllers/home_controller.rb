class HomeController < ApplicationController
  require_relative "../platform/trip_application"
  include TripApplication

  def index
    @trip = Trip.new
  end

  def submit_trip
    params=get_trip_params()
    perbus = params[:perbus]
    binding.pry
    @trip = Trip.new(params)

    @trip[:created_at] = Time.now
    if @trip.save
      send_customer_communications(@trip)
      send_admin_communications(@trip)
      redirect_to root_path , alert: 'success'
    else
      redirect_to root_path, alert: 'error'
    end
  end

  def terms_conditions

  end

  def about_us
  end

  def pricing
  end

  def contact_us
  end

  def payment_methods
  end

  private

  def get_trip_params()
    params[:trip].permit(:perbus, :tot,:tob, :adult, :chldrn, :pul, :pua, :put, :drl,:dra,:drt, :fname, :lname, :phone, :email, :gst, :gst_lg_nm, :gst_full_addr, :tick, :photoproof1, :photoproof2, :str, :locs1, :locs2, :locs3, :locs4, :msg, :created_at)
  end

end
