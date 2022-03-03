class SessionsController < ApplicationController

  def login
    if request.post?
      @admin = Admin.first
      params[:admin].permit(:password)
      password = params[:admin][:password]
      success = @admin.authenticate(password)
      if(success)
        redirect_to chennai106_path
      elsif(success == false)
        redirect_to admin_login_path
      end
    end
  end

end
