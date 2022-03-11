module TripApplication


  def get_gst_data(gst)
    response = HTTParty.post("https://appyflow.in/api/verifyGST",
              :body => {:key_secret => "XYhitWS1lrhpoKhDvyNo48d7BZL2", :gstNo => gst}.to_json,
              :headers => {'Content-Type' => 'application/json'}
              )
    response
  end

  def send_wa_messages(data)
    @trip_details = data
    payload = {}
    payload[:message] = {
        :channel => "WABA",
        :content => {
          :preview_url => false,
          :type => "TEMPLATE",
          :template => {
            :templateId => "admin_booking_confirmation",
            :parameterValues => {
              "0" => "Vijay",
              "1" => "Vijay",
              "2" => "Vijay",
              "3" => "Vijay",
              "4" => "Vijay",
              "5" => "Vijay",
              "6" => "Vijay",
              "7" => "Vijay",
              "8" => "Vijay",
              "9" => "Vijay",
              "10" => "Vijay"
            }
          }
        }
      }
      payload[:message][:recipient] = {
        :to => "919176016494",
        :recipient_type => 'individual',
        :reference => {
          :cust_ref => "Some Customer Ref",
          :messageTag1 => "Message Tag Val1",
          :conversationId => "Some Optional Conversation ID"
        }
      }
      payload[:message][:sender] = {
        :from => "919444516391",
      }
      payload[:message][:preferences] = {
        "webHookDNId": "1001"
      }
      payload[:metaData] = {
        :version => "v1.0.9"
      }

      binding.pry

      response = HTTParty.post("https://rcmapi.instaalerts.zone/services/rcm/sendMessage",
            :body => payload.to_json,
            :headers => {'Content-Type' => 'application/json',
                          'Authentication' => 'Bearer na2JvXULNrlLYfw1BzsMyw=='
                        }
          )
      binding.pry

  end


end
