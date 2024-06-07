# Preview all emails at http://localhost:3000/rails/mailers/emails/user
class Emails::UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/emails/user/confirmation
  def confirmation
    Emails::UserMailer.confirmation(User.first, "confirmation_token")
  end

  def password_reset
    Emails::UserMailer.password_reset(User.first, "password_reset_token")
  end
end
