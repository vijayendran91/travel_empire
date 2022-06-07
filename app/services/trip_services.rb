module TripServices

  def create_trip(trip_data)
    @trip = Trip.new(trip_data)
  end

  def save_trip
    result = false
    if(@trip.whatsapp_number == nil)
      result = false
    elsif
      result = @trip.save
    end
    return result
  end

  def get_trip_data_service(trip_id)
    return Trip.find_by(:id => trip_id)
  end

  def update_trip_status_service(trip_id, status)
    trip = get_trip_data_service(trip_id)
    trip.update_attribute(:trp_sts, status)
  end

end
