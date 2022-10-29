class SessionsController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    begin
      user = User.find_by(email: params[:email])
      if user.present?
        token = VerifyUserService.new(user, params[:password]).call
        if token.present?
          user.update!(token: token)
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
