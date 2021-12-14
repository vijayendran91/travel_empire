class AdminController < ApplicationController

  def home
    @admin = Admin.first
    @trips_obj = Trip.all
    @trips = []
    @trips_obj.each do |trip|
      @trips.push(trip)
    end
  end

  def login
    @admin = Admin.new
    @admin_password = Admin.first
    if request.get?
      
    elsif request.post?
      get_params()
      password = params[:admin][:password]
      result = @admin_password.authenticate(password) 
      if(result == false)
        flash.now[:danger] = "Invalid Password"  
        render admin_login_path
      elsif(result)
        redirect_to chennai106_path
      end
    end
  end

  private
  def get_params()
      params[:admin].permit(:password) 
  end



end
