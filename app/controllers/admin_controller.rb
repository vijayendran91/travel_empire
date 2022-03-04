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
    else
      @trips_obj = Trip.all
      @trips = []
      @trips_obj.each do |trip|
        @trips.push(trip)
      end
    end

    respond_to do |format|
      format.html {render 'admin/home.html.erb'}
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Trips from "'+Date.parse(params[:start_date]).strftime("%a %d-%m-%y")+" - "+Date.parse(params[:end_date]).strftime("%a %d-%m-%y")+'".xlsx"'
      }
    end
  end

  def trip_details
    params.permit(:id)
    @trip =  Trip.find_by(:id => params[:id])
  end

  def login
    if(request.get?)
      @admin = Admin.first
    end
  end


  private
    def get_params()
        params[:trip].permit(:start_date, :end_date)
    end
end
