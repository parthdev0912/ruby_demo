class MeetingConfirmationMailer < ApplicationMailer
  default from: 'sondigaraparth@gmail.com'

  def meeting_confirmation_email
    @user = params[:user]
    @meeting = params[:meeting]
    mail(to: @user.email, subject: "One new meeting for you !!!" )
  end

  def meeting_cancellation_email
    @user = params[:user]
    @meeting = params[:meeting]
    mail(to: @user.email, subject: "Your meeting is cancelled !!!" )
  end

  def meeting_rescheduled_email
    @user = params[:user]
    @meeting = params[:meeting]
    mail(to: @user.email, subject: "Your meeting is rescheduled !!!" )
  end

end
