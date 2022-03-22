module WhatsappHelper


  def time_difference_hrs(timestamp)
    now = Time.now
    difference = (timestamp.utc - now)
    return difference
  end

end
