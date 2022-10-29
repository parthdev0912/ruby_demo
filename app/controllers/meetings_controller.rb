class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:destroy, :edit, :update, :show]
  
  def new
    @meeting = Meeting.new
  end

  def create
    begin
      @meeting = Meeting.new(subject: params[:subject], description: params[:description], start_time: params[:start_time], complete: params[:complete], metting_with: params[:metting_with], user: @current_user)
      if @meeting.save!
        MeetingConfirmationMailer.with(user: @current_user, meeting: @meeting).meeting_confirmation_email.deliver_now
        flash[:notice] = "Meeting Created successfully !!!"
      else
        flash[:alert] = "Something is missing. Meeting was not created please try again..."  
      end
      redirect_to meetings_path
      rescue => exception
      logger.error exception.message
    end
  end
  
  def index
    begin
      @meetings = Meeting.where(user_id: @current_user.id)
    rescue => exception
      logger.error exception.message
    end
  end

  def edit; end

  def show; end

  def update
    begin
      @meeting.update(meeting_params)
      MeetingConfirmationMailer.with(user: @current_user, meeting: @meeting).meeting_rescheduled_email.deliver_now
      flash[:notice] = "Meeting updated successfully !!!"
      redirect_to meetings_path
    rescue => exception
      logger.error exception.message
    end
  end

  def destroy
    begin
      @meeting.destroy
      MeetingConfirmationMailer.with(user: @current_user, meeting: @meeting).meeting_cancellation_email.deliver_now
      flash[:alert] = "Meeting deleted successfully !!!"
      redirect_to meetings_path 
    rescue => exception
      logger.error exception.message
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:subject, :description, :start_time, :complete, :metting_with)
  end
end
