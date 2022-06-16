require_relative '../platform/trip_application'
require_relative '../platform/whatsapp_application'
require_relative '../platform/driver_module_application'
class DriverModuleController < ApplicationController
  include TripApplication
  include WhatsappApplication
  include DriverModuleApplication

  def status_change
  if request.post?
      trip_start_params = get_trip_start_params(params)
      trip_start_params[:trip_id] = params[:id]
      @trip_details = get_trip_data(params[:id])
      trip_status = @trip_details[:trp_sts]
      if(trip_status == Trip::TRIP_BOOKED.to_s)
        update_trip_status(params[:id], Trip::TRIP_STARTED)
        @driver_tr_srt = DriverModule.new(trip_start_params)
        if @driver_tr_srt.save
          send_customer_communications(@trip_details, :trip_start_driver, false)
          redirect_to trip_status_path
        else
          redirect_to trip_start_path
        end
      elsif trip_status== Trip::TRIP_STARTED.to_s
        update_trip_status(params[:id], Trip::TRIP_COMPLETE)
        update_driver_module(@trip_details.driver_module[:id], params[:driver_module])
        send_customer_communications(@trip_details, :trip_end_driver, false)
        redirect_to trip_status_path
      end
    elsif request.get?
      trip_id = params[:id]
      @trip_details = get_trip_data(trip_id)
      @status_flag = ""
      if @trip_details[:trp_sts] == Trip::TRIP_BOOKED.to_s
          @status_flag = Trip::TRIP_BOOKED
      elsif @trip_details[:trp_sts] == Trip::TRIP_STARTED.to_s
        @status_flag = Trip::TRIP_STARTED
      end
      @driver_details = DriverModule.new
    end
  end

private

  def get_trip_start_params(params)
    params.require(:driver_module).permit(:dr_name, :dr_mob, :st_km, :car_model, :lic_no, :dr_dl_no)
  end
end
