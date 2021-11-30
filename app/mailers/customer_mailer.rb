class CustomerMailer < ApplicationMailer
  
    
  def cab_booked 
    @trip = params[:trip]
    attachments.inline["logo.jpg"] = File.read("#{Rails.root}/app/assets/images/Travel_Empire_Logo_1.jpg")
    mail(to: @trip[:email], subject: 'TEST : Your Cab has been booked !!')
  end

end
