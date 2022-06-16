require_relative '../services/driver_module_services'

module DriverModuleApplication
  include DriverModuleServices


  def update_driver_module(id, params)

    update_params = {
      :cl_km => params[:cl_km],
      :total_toll => params[:total_toll],
      :permit => params[:permit],
      :cl_time => Time.now,
      :emp_name => params[:emp_name],
      :emp_id => params[:emp_id],
      :emp_phone => params[:emp_phone]
    }

    if (params[:in_city] == "1")
      update_params[:in_city] = true
    else
      update_params[:in_city] = false
    end
    update_driver_module_service(id, update_params)
  end
end
