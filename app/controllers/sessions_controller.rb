class SessionsController < ApplicationController

  def login
    if request.post?
      @admin = Admin.first
      params[:admin].permit(:password)
      password = params[:admin][:password]
      success = @admin.authenticate(password)
      if(success)
        session[:admin_logged] = "chennai106"
        redirect_to chennai106_path
      elsif(success == false)
        redirect_to admin_login_path, :alert => "Invalid Password"
      end
    end
  end

  def logout
    session[:admin_logged] = nil
    redirect_to admin_login_path
  end
end
