class WhatsappController < ApplicationController
  require_relative "../platform/whatsapp_application"
  include WhatsappApplication
  include WhatsappHelper

  skip_before_action :verify_authenticity_token
  def receive_msg
    params.permit(:eventContent)
    event_content = params[:eventContent]
    message = event_content[:message]
    phone = message[:from][2..-1]
    text = image = video = location = document = nil
    if(message)
      if(message[:text])

      elsif message[:audio]

      elsif message[:image]
        msg_type = WhatsappMessage::IMAGE
        image_data = get_wa_media(message)
        image = get_action_dispatch_upload_file(image_data.parsed_response, 'image/jpeg', 'customer_response_image.jpeg')
      elsif message[:video]
        msg_type = WhatsappMessage::VIDEO
        video_data = get_wa_media(message)
        video = get_action_dispatch_upload_file(video_data.parsed_response, 'video/mp4', 'customer_response_video.mp4')
      end
    end
    change_notification(phone, true)
    msg_type = get_wa_message_type(message)


    wa_message_insert(phone, WhatsappMessage::USER_INITIATED, WhatsappMessage::TEXT, WhatsappMessage::ADMIN, text, image, video, location, document)
    response = {:status => 200}
    response= response.to_json
    render :json => response
  end

  def voice_msg

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
        @messages = WhatsappMessage.where(:phone => params[:phone]).to_a
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
        if(@last_user_message && (time_difference_hrs(@last_user_message[:timestamp])<23.45))
          @template_flag = false
        end
      else
        @admin =  Admin.first
        redirect_to admin_login_path, :alert => "Please Log In"
      end
    elsif request.post?
      params.permit(:whatsapp_message)
      whatsapp_message = params[:whatsapp_message]
      wa_message_insert(whatsapp_message[:phone], whatsapp_message[:text_message], WhatsappMessage::TEXT,WhatsappMessage::ADMIN,whatsapp_message[:text_message], nil, nil, nil, nil)
      redirect_to admin_wa_messenger_path(:phone => whatsapp_message[:phone]), :method => 'get'
    end
  end

  private
    def get_user_sent_params
      params.permit(:channel, :appDetails, :events, :eventContent)
    end
end
# {
#   "channel"=>"WABA",
#   "appDetails"=>{
#     "type"=>"LIVE"
#     },
#   "events"=>{
#     "eventType"=>"User initiated",
#     "timestamp"=>"1647242162",
#     "date"=>"2022-March-14"
#   },
#   "eventContent"=>{
#     "message"=>
#       {
#         "from"=>"919962395973",
#         "id"=>"ABEGkZliOVlzAgo6q3kSFKkYNTa9",
#         "text"=>{
#           "body"=>"hi"},
#         "to"=>"919444516391",
#         "contentType"=>"text"
#       }
#     },
#     "controller"=>"whatsapp",
#     "action"=>"receive_msg",
#     "whatsapp"=>{
#       "channel"=>"WABA",
#       "appDetails"=>{
#         "type"=>"LIVE"
#         },
#       "events"=>{
#         "eventType"=>"User initiated",
#         "timestamp"=>"1647242162",
#         "date"=>"2022-March-14"
#         },
#         "eventContent"=>{
#           "message"=>{
#             "from"=>"919962395973",
#             "id"=>"ABEGkZliOVlzAgo6q3kSFKkYNTa9",
#             "text"=>{
#               "body"=>"hi"
#               },
#             "to"=>"919444516391",
#             "contentType"=>"text"}
#           }
#         }
# }
