class SessionsController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    begin
      user = User.find_by(email: params[:email])
      if user.present?
        data = user&.valid_password?(params[:password])
        if data.present?
          flash[:notice] = 'Sign in successfully !!!'
          redirect_to meetings_path
        else
          flash[:alert] = 'Please enter valid user id or password'
          redirect_to new_session_path
        end
      else
        flash[:alert] = 'Please do sign up first'
        redirect_to new_session_path
      end
    rescue => exception
      logger.error exception.message
    end
  end
end
