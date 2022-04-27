module WhatsappNumberServices

    def get_whatsapp_number_service(phone)
     return  WhatsappNumber.where(:phone => phone).first
    end

    def opt_out_phone_service(phone)
      phone = get_whatsapp_number_with_phone(phone)
      phone.update_attributes!(:opt_in => false)
    end

    def create_whatsapp_number_service(first_name, last_name, phone, opt_in, notification)
        result = WhatsappNumber.new(:first_name => first_name, :last_name => last_name, :phone => phone, :opt_in => opt_in, :notification => notification)
        return result
    end

    def save_whatsapp_number_service
      return  @wn.save
    end

    def change_notification_service(wa_phone, value)
      wa_phone.update(:notification => value)
    end
end
