class WhatsappController < ApplicationController
  require_relative "../platform/whatsapp_application"
  include WhatsappApplication
  include WhatsappHelper

  skip_before_action :verify_authenticity_token

  def receive_msg
    params.permit(:eventContent)
    event_content = params[:eventContent]
    message = event_content[:message]
    phone = message[:from]
    text = image = video = location = document = nil
    if(message)
      if(message[:text])
        msg_type = WhatsappMessage::TEXT
        text = message[:text][:body]
      elsif message[:location]
        msg_type = WhatsappMessage::LOCATION
        location = get_wa_media(message)
      elsif message[:voice]
        msg_type = WhatsappMessage::VOICE
        voice_data = get_wa_media(message)
        voice = get_action_dispatch_upload_file(voice_data.parsed_response, 'audio/ogg; codecs=opus', 'customer_response_voice.ogg')
      elsif message[:image]
        msg_type = WhatsappMessage::IMAGE
        image_data = get_wa_media(message)
        image = get_action_dispatch_upload_file(image_data.parsed_response, 'image/jpeg', 'customer_response_image.jpeg')
      elsif message[:video]
        msg_type = WhatsappMessage::VIDEO
        video_data = get_wa_media(message)
        video = get_action_dispatch_upload_file(video_data.parsed_response, 'video/mp4', 'customer_response_video.mp4')
      elsif message[:document]
        msg_type = WhatsappMessage::DOCUMENT
        extension = ""
        doc_data = get_wa_media(message)
        doc_type = doc_data.headers["content-type"]
        if(doc_type == "application/msword")
          extension = ".doc"
        elsif doc_type == "application/pdf"
          extension = ".pdf"
        end
        document = get_action_dispatch_upload_file(doc_data.parsed_response, doc_data.headers["content-type"], 'customer_response_document'+extension)
      end
    end
    change_notification(phone, true)

    wa_message_insert(phone, WhatsappMessage::USER_INITIATED, msg_type, WhatsappMessage::USER, text, image, video, voice, location, document)
    response = {:status => 200}
    response= response.to_json
    render :json => response
  end

  def wa_index
    if admin_logged_in?
      wa_numbers = WhatsappNumber.all
      @wa_list = []
      @wa_messages = []
      wa_numbers.each do |x|
        @wa_list.push(x)
      end
    else
      @admin =  Admin.first
      redirect_to admin_login_path, :alert => "Please Log In"
    end
  end

  def wa_messenger
    if request.get?
      if admin_logged_in?
        params.permit(:phone)
        change_notification(params[:phone], false)
        @wa_number =WhatsappNumber.where(:phone => params[:phone]).first
        @messages = WhatsappMessage.where(:phone => params[:phone]).order_by(:timestamp => :asc)
        @phone = params[:phone]
        @new_message = WhatsappMessage.new
        @template_flag  = true
        @last_user_message = nil
        last = @messages.last
        @messages.reverse.each do |m|
          if(m[:sent_by] == 'user')
            @last_user_message = m
            break
          end
        end
        if(!@last_user_message.nil? && (time_difference_hrs(@last_user_message[:timestamp])<86400))
          @template_flag = false
        end
      else
        @admin =  Admin.first
        redirect_to admin_login_path, :alert => "Please Log In"
      end
    elsif request.post?
      params.permit(:whatsapp_message, :message_type)
      if(params[:whatsapp_message][:template] != "true")
        send_conv_reply(params[:whatsapp_message])
      elsif(params[:whatsapp_message][:template] == "true")
        customer_wa_init(params[:whatsapp_message], params[:whatsapp_message][:text_message])
      end
      redirect_to admin_wa_messenger_path(:phone => params[:whatsapp_message][:phone]), :method => 'get'
    end
  end

  private
    def get_user_sent_params
      params.permit(:channel, :appDetails, :events, :eventContent)
    end
end
