module WhatsappApplication

  def send_customer_communications(trip_details, wa_template)
    @trip = trip_details
    CabBookedMailer.with(:trip=>@trip).cab_booked_passenger.deliver_now
    customer_wa_init(wa_template)
  end

  def customer_wa_init(wa_template)
    opt_in = wa_opt_in?(@trip[:phone])
    opt_in_phone(@trip[:phone]) if (opt_in == false)
    case wa_template.to_s
    when "customer_booking_confirmation"
      payload = booking_conf_cust_wa_pl
      wa_message_insert(@trip[:phone], wa_template, WhatsappMessage::TEXT, WhatsappMessage::ADMIN, wa_template, nil)
    else

    end
    send_wa_message(payload)
  end


  def wa_message_insert(phone, wa_template, type,sent_by,text_message, media)
    wa_message = {
      :phone => phone,
      :sent_by => sent_by,
      :message_type => type,
      :text_message => text_message,
      :timestamp => Time.now
    }
    wa_message[:phone] = phone
    wa_message[:sent_by] = sent_by
    wa_message[:message_type] = type
    wa_message[:text_message] = text_message
    wa_message[:timestamp] = Time.now
    case type
    when WhatsappMessage::TEXT

    when WhatsappMessage::VIDEO
      wa_message[:video] = media
    when WhatsappMessage::LOCATION
      wa_message[:location] = media
    end
    result = WhatsappMessage.new(wa_message)
    result.save
  end


  def wa_opt_in?(phone)
    data = WhatsappNumber.where(:phone => phone).first
    if data.nil?
      return false
    else
      return true
    end
  end

  def opt_in_phone(phone) #TODO HTTP GET method to OPTIN the phone number
    
  end

  def opt_out_phone
    opt = WhatsappNumber.new(:phone => phone, :opt_in => true)
    opt[:opt_in] = false
    opt.save
  end


  def send_admin_communications(trip_details, wa_template)
    @trip = trip_details
    CabBookedMailer.with(:trip=>@trip).cab_booked_admin.deliver_now
    payload = booking_conf_admin_wa_pl
    send_wa_message(payload)
  end


  def booking_conf_admin_wa_pl
    payload = {}
    payload[:message] = {
        :channel => "WABA",
        :content => {
          :preview_url => false,
          :type => "TEMPLATE",
          :template => {
            :templateId => "admin_booking_confirmation",
            :parameterValues => {
              "0" => "*#{@trip[:pul]} - #{@trip[:pua]}*",
              "1" => @trip[:put].strftime("%a %d-%m-%y  %l:%M:%p"),
              "2" => Trip::TYPE_OF_TRIP[@trip[:tot].to_sym],
              "3" => "*#{@trip[:drl]} - #{@trip[:dra]}*",
              "4" => @trip[:drt].strftime("%a %d-%m-%y  %l:%M:%p"), #TODO - ONE Way stores the time of booking
              "5" => @trip[:str],
              "6" => @trip[:adult],#TODO - Add adult and children
              "7" => "*#{@trip[:fname]} #{@trip[:lname]}*",
              "8" => @trip[:phone],
              "9" => @trip[:email],
              "10" => @trip[:id].to_s
            }
          }
        }
      }
      payload[:message][:recipient] = {
        :to => "919962395973",
        :recipient_type => 'individual',
        :reference => {
          :cust_ref => "Some Customer Ref",
          :messageTag1 => "Message Tag Val1",
          :conversationId => @trip[:id].to_s
        }
      }
    return payload
  end

  def booking_conf_cust_wa_pl
    payload = {}
    payload[:message] = {
        :channel => "WABA",
        :content => {
          :preview_url => false,
          :shorten_url => false,
          :type => "MEDIA_TEMPLATE",
          :mediaTemplate => {
            :templateId => "customer_booking_confirmation",
            :media => {
              :type => "video",
              :url => "https://travel-empire-proofs.s3.ap-south-1.amazonaws.com/booking_conf_vm/booking_conf_vm.mp4"
            },
            :bodyParameterValues => {
              "0" => @trip[:fname],
              "1" => "*#{@trip[:pul]} - #{@trip[:pua]}*",
              "2" => @trip[:put].strftime("%a %d-%m-%y  %l:%M:%p"),
              "3" => Trip::TYPE_OF_TRIP[@trip[:tot].to_sym], #TODO - ONE Way stores the time of booking
              "4" => "*#{@trip[:drl]} - #{@trip[:dra]}*",
              "5" => @trip[:drt].strftime("%a %d-%m-%y  %l:%M:%p"),
              "6" => @trip[:str],
              "7" => @trip[:id].to_s, #TODO - Add adult and children

            }
          }
        }
      }
      payload[:message][:recipient] = {
        :to => "919884538873",
        :recipient_type => 'individual',
        :reference => {
          :cust_ref => "Some Customer Ref",
          :messageTag1 => "Message Tag Val1",
          :conversationId => "Some Optional Conversation ID"
        }
      }

    return payload
  end

  def send_wa_message(payload)

    payload[:message][:sender] = {
      :from => "919444516391",
    }
    payload[:message][:preferences] = {
      "webHookDNId": "1001"
    }
    payload[:metaData] = {
      :version => "v1.0.9"
    }
    response = HTTParty.post("https://rcmapi.instaalerts.zone/services/rcm/sendMessage",
          :body => payload.to_json,
          :headers => {'Content-Type' => 'application/json',
                        'Authentication' => 'Bearer na2JvXULNrlLYfw1BzsMyw=='
                      }
        )
  end

  def get_wa_message_type(message)
    result = nil
    if(message)
      if(message[:text])
        result = WhatsappMessage::TEXT
      elsif message[:audio]

      elsif message[:image]
        result = WhatsappMessage::IMAGE
      elsif message[:video]
        result = WhatsappMessage::VIDEO
      end
    end
  end

  def get_wa_media(message)
    result = nil
    if(message)
      if(message[:text])
        result = WhatsappMessage::TEXT
      elsif message[:audio]

      elsif message[:image]
        result = WhatsappMessage::IMAGE
      elsif message[:video]
        result = WhatsappMessage::VIDEO
      end
    end
  end
end
