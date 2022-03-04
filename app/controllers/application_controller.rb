class ApplicationController < ActionController::Base
  PAYU_MONEY_LINK="https://pmny.in/aIlQzaGFxaIb"

  def admin_logged_in?
    if(session[:admin_logged] && session[:admin_logged] == "chennai106")
      return true
    else
      return false
    end
  end
end
