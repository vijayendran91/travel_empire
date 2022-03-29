module WhatsappHelper

  def time_difference_hrs(timestamp)
    now = Time.now
    difference = (now - timestamp.utc)
    return difference
  end

end
