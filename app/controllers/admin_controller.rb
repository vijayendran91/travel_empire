class AdminController < ApplicationController

  def home
    if params[:format] == "xlsx"
      params = get_params()
      @trips = Trip.where(:created_at.gte => params[:start_date], :created_at.lte => params[:end_date])
      @tot = []
      @perbus = []
      (0..@trips.length-1).each do |i|
        @tot[i] = Trip::TYPE_OF_TRIP[@trips[i][:tot].to_sym]
        @perbus[i] = Trip::TRIP_TYPE[@trips[i][:perbus].to_sym]
      end
    end

    respond_to do |format|
      if admin_logged_in?
        @trips_obj = Trip.all
        @trips = []
        @trips_obj.each do |trip|
          @trips.push(trip)
        end
        format.html {render 'admin/home.html.erb'}
      else
        @admin = Admin.first
        format.html {render 'admin/login.html.erb', :locals => {:alert => "Please Log in"}}
      end
      format.html {render 'admin/home.html.erb'}
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Trips from "'+Date.parse(params[:start_date]).strftime("%a %d-%m-%y")+" - "+Date.parse(params[:end_date]).strftime("%a %d-%m-%y")+'".xlsx"'
      }
    end
  end

  def trip_details
    if admin_logged_in?
      params.permit(:id)
      @trip =  Trip.find_by(:id => params[:id])
    else
      @admin =  Admin.first
      redirect_to admin_login_path, :alert => "Please Log In"
    end
  end

  def login
    if(request.get?)
      @admin = Admin.first
    end
  end

  def cancel_trip
    if admin_logged_in?
      id = params.permit(:id)[:id]
      trip = Trip.where(:id => id).delete
      redirect_to chennai106_path
    else
      @admin =  Admin.first
      redirect_to admin_login_path, :alert => "Please Log In"
    end
  end

  def wa_index
    if admin_logged_in?
      wa_numbers = WhatsappOpt.all
      @wa_list = []
      @wa_messages = []
      wa_numbers.each do |x|
        @wa_list.push(x[:phone])
      end
    else
      @admin =  Admin.first
      redirect_to admin_login_path, :alert => "Please Log In"
    end
  end

  def wa_messenger
    if admin_logged_in?
      params.permit(:phone)
      @messages = WhatsappMessage.where(:phone => params[:phone])
    else
      @admin =  Admin.first
      redirect_to admin_login_path, :alert => "Please Log In"
    end
  end

  private
    def get_params()
        params[:trip].permit(:start_date, :end_date)
    end
end
