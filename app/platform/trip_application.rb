require_relative "../services/trip_services"

module TripApplication
  include TripServices

  def get_gst_data(gst)
    response = HTTParty.post("https://appyflow.in/api/verifyGST",
              :body => {:key_secret => "XYhitWS1lrhpoKhDvyNo48d7BZL2", :gstNo => gst}.to_json,
              :headers => {'Content-Type' => 'application/json'}
              )
    response
  end

  def get_trip_data(trip_id)
    get_trip_data_service(trip_id)
  end

  def update_trip_status(trip_id, status)
    update_trip_status_service(trip_id, status)
  end

end
