class OmniauthController < ApplicationController
  # Handle the omniauth callback from Twitter
  def twitter
    auth = request.env['omniauth.auth']
    @twitter_account = TwitterAccount.from_omniauth(auth)
    redirect_to @twitter_account, notice: 'Twitter account has been authorized.'
  end

  # Handle failed omniauth authorization requests
  def failure
    redirect_to twitter_accounts_path, alert: 'Twitter account could NOT be authorized.'
  end
end
