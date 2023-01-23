class UserMailer < ApplicationMailer
  def reset_password user
    @user = user
    mail(to: @user.email, subject: 'Songsemble: Reset Password')
  end
end
