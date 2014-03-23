class UserNotifier < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://#{URL_BASE}/account/activate/#{user.activation_code}"
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{URL_BASE}/"
  end

protected

  def setup_email(user)
    @recipients  = "#{user.login}"
    @from        = "info@#{URL_BASE}"
    @subject     = "Welcome to #{URL_BASE.humanize}"
    @sent_on     = Time.now
    @body[:user] = user
  end
end
