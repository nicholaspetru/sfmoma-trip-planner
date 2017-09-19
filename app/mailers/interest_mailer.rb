class InterestMailer < ApplicationMailer
  default from: 'nicholaspetru@gmail.com'

  def user_interest_mailer(user)
    @user = user
    @artists = Interest.where('user_id' => @user.username).pluck(:artist_slug)
    @artworks = Interest.where('user_id' => @user.username).pluck(:artwork_slug)
    mail(to: @user.email, subject: 'Here are your current interests')
  end
end
