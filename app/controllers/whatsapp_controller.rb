class WhatsappController < ApplicationController
  require_relative "../platform/whatsapp_application"
  include WhatsappApplication


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
