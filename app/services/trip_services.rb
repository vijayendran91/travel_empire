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

end
