class CabBookedMailer < ApplicationMailer
  ADMIN_MAIL = "chennai.travelempire@yahoo.com"
    
  def cab_booked_passenger 
    @trip = params[:trip]
    @pick_up_time = @trip[:put].strftime("%a %d-%m-%y")
    @tot = Trip::TYPE_OF_TRIP[@trip[:tot].to_sym]
    attachments.inline["logo.jpg"] = File.read("#{Rails.root}/app/assets/images/Travel_Empire_Logo_1.jpg")
    mail(to: @trip[:email], subject: 'Your Cab has been booked !!')
  end

  def cab_booked_admin
    @trip = params[:trip]
    @tot = Trip::TYPE_OF_TRIP[@trip[:tot].to_sym] 
    @pick_up_time = @trip[:put].strftime("%a %d-%m-%y")
    attachments.inline["logo.jpg"] = File.read("#{Rails.root}/app/assets/images/Travel_Empire_Logo_1.jpg")
    mail(to: ADMIN_MAIL, subject: 'A ride has been booked for date '+@pick_up_time)
  end

end
