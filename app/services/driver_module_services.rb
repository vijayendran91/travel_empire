module DriverModuleServices

  def update_driver_module_service(id, params)
    DriverModule.where(:id => id).update_all(params)
  end
end
