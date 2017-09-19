# Preview all emails at http://localhost:3000/rails/mailers/interest_mailer
class InterestMailerPreview < ActionMailer::Preview
  def user_interest_mailer
    InterestMailer.user_interest_mailer(User.third)
  end
end
