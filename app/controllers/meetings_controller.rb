class MeetingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @meetings = Meeting.where(user_id: @current_user.id)
  end
end
