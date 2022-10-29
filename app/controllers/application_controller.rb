class ApplicationController < ActionController::Base
  helper_method :authenticate_user!, :date_format

  def authenticate_user!
    begin
      token = session[:token] if session[:token]
      if token.present?
        decoded_token = JsonWebToken.decode(token)
        @current_user = User.find_by(id: decoded_token[:id], email: decoded_token[:email])
      else
        flash[:alert] = "Please do sign in first"
        redirect_to new_session_path
      end
    rescue => exception
      logger.error exception.message
    end
  end

  def date_format(date)
    date.strftime("%d / %m / %Y - %H:%M")
  end
end
