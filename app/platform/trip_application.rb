module TripApplication 
  
  
  def get_gst_data(gst)
    response = HTTParty.post("https://appyflow.in/api/verifyGST",
              :body => {:key_secret => "XYhitWS1lrhpoKhDvyNo48d7BZL2", :gstNo => gst}.to_json,
              :headers => {'Content-Type' => 'application/json'}
              ) 
    response
  end


end
