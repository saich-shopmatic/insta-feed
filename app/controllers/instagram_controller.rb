class InstagramController < ApplicationController

APP_ID = '2442856189377592'
APP_SECRET = 'f67fddd13316758175939c5fe0aaaca5' 
REDIRECT_URI =  'https://1b222f40.ngrok.io/oauth/callback'   ##'https://saich-insta-feed.herokuapp.com/oauth/callback/'
GRANT_TYPE = 'authorization_code'
ACCESSTOKEN_URL = 'https://api.instagram.com/oauth/access_token'
AUTH_URL = "https://api.instagram.com/oauth/authorize?app_id=#{APP_ID}&redirect_uri=#{REDIRECT_URI}&scope=user_profile,user_media&response_type=code"

  ## Authorization
  def connect
    redirect_to AUTH_URL
  end

  ## redirect_uri & get auth code here
  def callback
    auth_code = params[:code].present? ? params[:code] : nil
    begin    
    if auth_code.present?            
        response = fetchAccessToken(auth_code)
        Rails.logger.info("Access token API Response: #{JSON.parse(response)}")
        redirect_to controller: 'home', action: 'index',  access_token: response, user_id: response
      else
        Rails.logger.info("Authorization is not present")
        redirect_to :root   
      end
    rescue => e
      Rails.logger.info("API failed: #{e.message}")
      redirect_to :root 
    end
  end

  def media
  end

  def feed
  end

  private 

    def fetchAccessToken(auth_code) 
      params = {app_id: APP_ID, app_secret: APP_SECRET, grant_type: GRANT_TYPE, redirect_uri: REDIRECT_URI, code: auth_code}
      Rails.logger.info(params)
      response = Curl.post(ACCESSTOKEN_URL, params)
      Rails.logger.info("Access Token API: #{response.body_str}")
      return response.body_str
    end
    


end
