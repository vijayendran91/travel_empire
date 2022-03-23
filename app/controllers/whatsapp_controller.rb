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
    msg_type = get_wa_message_type(message)
    media = get_wa_media(message)
    wa_message_insert(phone, WhatsappMessage::USER_INITIATED, msg_type, WhatsappMessage::USER, message[:text][:body], media)
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
        @wa_list.push(x[:phone])
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
        @messages = WhatsappMessage.where(:phone => params[:phone])
        @phone = params[:phone]
        @new_message = WhatsappMessage.new
        @template_flag  = true
        last = @messages.last
        @messages = @messages.reverse
        last_user = last[:sent_by]
        last_time_diff = time_difference_hrs(last[:timestamp])
        if((last_user == WhatsappMessage::USER) && (last_time_diff < 23.45))
          @template_flag = false
        end
        # binding.pry
      else
        @admin =  Admin.first
        redirect_to admin_login_path, :alert => "Please Log In"
      end
    elsif request.post?
      params.permit(:whatsapp_message)
      whatsapp_message = params[:whatsapp_message]
      wa_message_insert(whatsapp_message[:phone], whatsapp_message[:text_message], WhatsappMessage::TEXT,WhatsappMessage::ADMIN,whatsapp_message[:text_message], WhatsappMessage::TEXT)
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
