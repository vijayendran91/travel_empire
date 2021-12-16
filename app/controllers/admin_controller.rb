class AdminController < ApplicationController

  def home
    if params[:format] == "xlsx"
      params = get_params()
      @trips = Trip.where(:created_at.gte => params[:start_date], :created_at.lte => params[:end_date])
      @tot = []
      (0..@trips.length-1).each do |i|
        @tot[i] = Trip::TYPE_OF_TRIP[@trips[i][:tot].to_sym]
      end
    else
      @trips_obj = Trip.all
      @trips = []
      @trips_obj.each do |trip|
        @trips.push(trip)
      end
    end

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Trips from "'+Date.parse(params[:start_date]).strftime("%a %d-%m-%y")+" - "+Date.parse(params[:end_date]).strftime("%a %d-%m-%y")+'".xlsx"'
      }
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
        params[:trip].permit(:start_date, :end_date)
    end
end
