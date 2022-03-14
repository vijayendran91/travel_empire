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
