class HomeController < ApplicationController
  require_relative "../platform/trip_application"
  require_relative "../platform/whatsapp_application"
  require_relative "../services/trip_services"
  include TripApplication
  include WhatsappApplication
  include TripServices
  def index
    @trip = Trip.new
  end

  def submit_trip
    params=get_trip_params()
    params[:created_at] = Time.now
    @trip = create_trip(params)
    @wn = get_wa_number(params[:phone])
    if(@wn == nil)
      @wn = create_wa_number_first(params[:phone])
    end
    @wn.trips.push(@trip)
    if save_trip && save_wa_number
      send_customer_communications(@trip, :customer_booking_confirmation)
      send_admin_communications(@trip, :admin_booking_confirmation)
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
