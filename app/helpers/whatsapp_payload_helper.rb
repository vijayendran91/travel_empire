module WhatsappPayloadHelper

  def booking_conf_admin_wa_pl(trip_data)
    payload = {}
    payload[:message] = {
        :channel => "WABA",
        :content => {
          :preview_url => false,
          :type => "TEMPLATE",
          :template => {
            :templateId => "admin_booking_confirmation",
            :parameterValues => {
              "0" => "*#{trip_data[:pul]} - #{trip_data[:pua]}*",
              "1" => trip_data[:put].strftime("%a %d-%m-%y  %l:%M:%p"),
              "2" => Trip::TYPE_OF_TRIP[trip_data[:tot].to_sym],
              "3" => "*#{trip_data[:drl]} - #{trip_data[:dra]}*",
              "4" => trip_data[:drt].strftime("%a %d-%m-%y  %l:%M:%p"), #TODO - ONE Way stores the time of booking
              "5" =>trip_data[:str],
              "6" => trip_data[:adult],#TODO - Add adult and children
              "7" => "*#{trip_data[:fname]} #{trip_data[:lname]}*",
              "8" =>trip_data[:phone],
              "9" => trip_data[:email],
              "10" => trip_data[:id].to_s
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


  def booking_conf_cust_wa_pl(trip_data)
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
              "0" => trip_data[:fname],
              "1" => "*#{trip_data[:pul]} - #{trip_data[:pua]}*",
              "2" => trip_data[:put].strftime("%a %d-%m-%y  %l:%M:%p"),
              "3" => Trip::TYPE_OF_TRIP[trip_data[:tot].to_sym], #TODO - ONE Way stores the time of booking
              "4" => "*#{trip_data[:drl]} - #{trip_data[:dra]}*",
              "5" => trip_data[:drt].strftime("%a %d-%m-%y  %l:%M:%p"),
              "6" => trip_data[:str],
              "7" => trip_data[:id].to_s, #TODO - Add adult and children

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
          :conversationId => "Some Optional Conversation ID"
        }
      }

    return payload
  end

  def customer_conv_text(phone, text)
    payload = {}

    payload[:message] = {
        :channel => "WABA",
        :content => {
          :preview_url => false,
          :text => text,
          :type => "TEXT",
        }
      }
    payload[:message][:recipient] = {
      :to => phone,
      :recipient_type => 'individual',
      :reference => {
        :cust_ref => "Some Customer Ref",
        :messageTag1 => "Message Tag Val1",
        :conversationId => "Some Optional Conversation ID"
      }
    }
    return payload
  end

end
