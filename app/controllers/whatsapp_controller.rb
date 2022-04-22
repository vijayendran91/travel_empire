class WhatsappController < ApplicationController
  skip_before_action :verify_authenticity_token
  def receive_msg
    print "\n\n\n Whatsapp response #{params} \n\n\n"
    params.permit(:channel, :appDetails, :events, :eventContent)
    channel = params[:channel]
    app_details = params[:appDetails]
    events = params[:events]
    event_content = params[:eventContent]
    message = event_content[:message]
    response = {:status => 200}
    response= response.to_json
    render :json => response
  end

  def voice_msg

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
