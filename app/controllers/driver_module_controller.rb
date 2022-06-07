require_relative '../platform/trip_application'

class DriverModuleController < ApplicationController
  include TripApplication

  def trip_start
  if request.post?
      trip_start_params = get_trip_start_params(params)
      trip_start_params[:trip_id] = params[:id]
      update_trip_status(params[:id], Trip::TRIP_STARTED)
      @driver_tr_srt = DriverModule.new(trip_start_params)
      if @driver_tr_srt.save
        redirect_to trip_status_path
      else
        redirect_to trip_start_path
      end
    elsif request.get?
      trip_id = params[:id]
      @trip_details = get_trip_data(trip_id)
      @status_flag = ""
      if @trip_details[:trp_sts] == Trip::TRIP_STARTED.to_s
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
