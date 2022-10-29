class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:destroy, :edit, :update]
  
  def new
    @meeting = Meeting.new
  end

  def create
    begin
      @meeting = Meeting.new(subject: params[:subject], description: params[:description], starts: params[:starts], complete: params[:complete], metting_with: params[:metting_with], user: @current_user)
      if @meeting.save!
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

  def update
    begin
      @meeting.update(meeting_params)
      flash[:notice] = "Meeting updated successfully !!!"
      redirect_to meetings_path
    rescue => exception
      logger.error exception.message
    end
  end

  def destroy
    begin
      @meeting.destroy
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
    params.require(:meeting).permit(:subject, :description, :starts, :complete, :metting_with)
  end
end
