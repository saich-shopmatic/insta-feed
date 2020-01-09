class InstagramController < ApplicationController
AUTH_URL = 'https://api.instagram.com/oauth/authorize?app_id=554472575139442&redirect_uri=https://saich-insta-feed.herokuapp.com/oauth/callback/&scope=user_profile,user_media&response_type=code';
APP_ID = '554472575139442'
APP_SECRET = '70a56acaa155786732231f381d84a2e9' 
REDIRECT_URI = 'https://saich-insta-feed.herokuapp.com/oauth/callback/'
GRANT_TYPE= 'authorization_code'
ACCESSTOKEN_URL = 'https://api.instagram.com/oauth/access_token'

  ## Authorization
  def connect
    redirect_to AUTH_URL
  end

  ## redirect_uri & get auth code here
  def callback
    Rails.logger.info(params)
    redirect_to :root
  end

  def media
  end

  def feed
  end
end
