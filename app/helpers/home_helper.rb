module HomeHelper

  def get_gst_appyflow()
    binding.pry
    response = HTTParty.post("https://example.com?param1=value1",
                :body => {:text => data}.to_json,
                :headers => {'Content-Type' => 'application/json'}
                      )
  end

end
