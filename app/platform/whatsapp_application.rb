require_relative "../services/whatsapp_number_services"

module WhatsappApplication
  include WhatsappNumberServices
  include WhatsappHelper
  include WhatsappPayloadHelper

  def send_customer_communications(trip_details, wa_template)
    CabBookedMailer.with(:trip=>trip_details).cab_booked_passenger.deliver_now
    customer_wa_init(trip_details, wa_template)
  end

  def customer_wa_init(data, wa_template)
    case wa_template.to_s
    when "delayed_response_regret"

    when "customer_booking_confirmation"
      if(data.whatsapp_number.opt_in == false)
        opt_in_phone(data[:phone])
      end
      payload = booking_conf_cust_wa_pl(data)
      wa_message_insert(data[:phone], wa_template, WhatsappMessage::TEXT, WhatsappMessage::ADMIN, wa_template, nil, nil, nil, nil,nil)
    else

    end
    response = send_wa_message(payload)
  end


  def wa_message_insert(phone, wa_template, type,sent_by, text, image, video, voice, location, document)
    wa_message = {
      :phone => phone,
      :sent_by => sent_by,
      :message_type => type,
      :text_message => text,
      :image => image,
      :video => video,
      :voice => voice,
      :location => location,
      :document => document,
      :timestamp => Time.now
    }
    result = WhatsappMessage.new(wa_message)
    result.save
  end


  def wa_opt_in?(phone)
    data = get_whatsapp_number_service(phone)[:opt_in]
    return data
  end

  def opt_in_phone(phone) #TODO HTTP GET method to OPTIN the phone number

  end

  def opt_out_phone(phone)
    opt_out_phone(phone)
  end


  def send_admin_communications(trip_details, wa_template)
    CabBookedMailer.with(:trip=>trip_details).cab_booked_admin.deliver_now
    payload = booking_conf_admin_wa_pl(trip_details)
    response = send_wa_message(payload)
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
    return response
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

  def get_msg_type_from_content_type(content_type)
    result = ""
    if((content_type == 'image/png') || (content_type == 'image/jpeg') || (content_type == 'image/jpg'))
      result = WhatsappMessage::IMAGE
    else
      result = WhatsappMessage::TEXT
    end
    result
  end

  def get_wa_media(message)
    result = nil
    if(message)
      if(message[:text])
        result = WhatsappMessage::TEXT
      elsif message[:location]
        result = {:latitude => message[:location]["latitude"], :longitude => message[:location]["longitude"]}
      elsif message[:image]
        result = get_wa_media_api_call(message[:image][:fileLink], message[:image][:sha256])
      elsif message[:video]
        result = get_wa_media_api_call(message[:video][:fileLink], message[:video][:sha256])
      elsif message[:voice]
        result = get_wa_media_api_call(message[:voice][:fileLink], message[:voice][:sha256])
      elsif message[:document]
        result = get_wa_media_api_call(message[:document][:fileLink], message[:document][:sha256])
      end
    end
    return result
  end

  def get_wa_number(phone)
    get_whatsapp_number_service(phone)
  end

  def create_wa_number_first(phone)
    return create_whatsapp_number_service(phone,true,false)
  end

  def save_wa_number
    return save_whatsapp_number_service
  end

  def change_notification(phone, value)
    @wa_phone = get_wa_number(phone)
    change_notification_service(@wa_phone, value)
  end

  def send_conv_reply(wa_msg)
    media_type = get_msg_type_from_content_type(wa_msg[:media].content_type)
    text = image = video = voice = text = location = document = nil
    if(media_type == WhatsappMessage::TEXT)
      text = wa_msg[:text_message]
      payload = customer_conv_text(wa_msg[:phone], wa_msg[:text_message])
      wa_message_insert(wa_msg[:phone], WhatsappMessage::CONVERSATION, media_type, WhatsappMessage::ADMIN, text, image, video, voice, location, document)
      response = send_wa_message(payload)
    elsif(media_type == WhatsappMessage::IMAGE)
      image = wa_msg[:media]
      encoded_image = encode_media_base64(wa_msg[:media])
      wa_message_insert(wa_msg[:phone], WhatsappMessage::CONVERSATION, media_type, WhatsappMessage::ADMIN, text, image, video, voice, location, document)
      payload = customer_conv_image(encoded_image, wa_msg[:phone], wa_msg[:media].content_type)
      response = send_wa_message(payload)
      print "\n\nresponse\n\n"
    end
  end
end
