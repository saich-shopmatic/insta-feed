class InstagramController < ApplicationController

APP_ID = 'shopmatic-2442856189377592'
APP_SECRET = 'shopmatic-f67fddd13316758175939c5fe0aaaca5' 
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
        Rails.logger.info("Access token API Response: #{response}")
        session[:access_token] = response["access_token"]
        session[:user_id] = response["user_id"]
        session[:expires_at] = Time.zone.now + 60.minutes
        redirect_to controller: 'home', action: 'index',  access_token: response["access_token"], user_id: response["user_id"]
      else
        Rails.logger.info("Authorization is not present")
        redirect_to :root   
      end
    rescue => e
      Rails.logger.info("API failed: #{e.message}")
      redirect_to :root 
    end
  end

 
  def user_media_feed

    # curl "https://graph.instagram.com/17841401686832877?access_token=IGQVJYNmNzLW1aUktUNDB5VWhkMXZAZANVhTRzE1dU5FMndOeVp1SmVtLXNwd3R2LUhIQXF0emZAaaU9jUnlHamtFRFk1Y2VfMnhFQVRDbklrNnhZAN1FweFExUklra1IzV0JyQUQ0VmpxWjlqdjB2U2tkcElEeW13MDlURzFr&fields=id,media_count,username,media" \
    # -H 'Cookie: ig_did=38414875-9838-473C-840B-86EDA77036DB; mid=XhciFwAEAAF8thXkjOeuVG2r_cTr; csrftoken=ztG7KambkZyLS1w0rTwlWRockB5afC22; rur=ASH'
    # Response :
    # {
    #   "id": "17841401686832877",
    #   "media_count": 7,
    #   "username": "chsai.btech",
    #   "media": {
        # "data": [
        #   {
        #     "id": "18040303081200401"
        #   },
        #   {
        #     "id": "17943139516254540"
        #   },
        #   {
        #     "id": "17873541031160915"
        #   },
        #   {
        #     "id": "17875776946190036"
        #   },
        #   {
        #     "id": "17872424590157226"
        #   },
        #   {
        #     "id": "17843566666056228"
        #   },
        #   {
        #     "id": "17843555053056228"
        #   }
        # ],
    #     "paging": {
    #       "cursors": {
    #         "before": "QVFIUm1ES0FGaUVuWjIxX1hXYTAtWm1KRmh4S1drdnlndlUwb1kyb2p1OXExVXZAtSHZApTXNVWWNMbHlRdW1zd2dmSW5rLU1DRVlpNk9oeUNoYzlsdVVoZATFB",
    #         "after": "QVFIUlkwdGNTaFdGSThjS1BUc1RMUUtGR3B5ZAFJySUN1LVFEYXZACSWJ4aUlwZAG05LTVTUHl4LUYtT1hjSWZA2OVRMaHBfeVNxc05ZAZAmFBaU43RUN0VkVVdEhB"
    #       }
    #     }
    #   }
    # }
    if session[:expires_at] < Time.zone.now
      session[:access_token] = nil
      session[:user_id] = nil
      session[:user_name] = nil
      session[:media_count] = nil
    end

    if session[:user_id].present? && session[:access_token].present?
      user_media_url = "https://graph.instagram.com/#{session[:user_id]}?access_token=#{session[:access_token]}&fields=id,media_count,username,media"
      raw_response = Curl.get(user_media_url)
      response = JSON.parse(raw_response.body_str)
      Rails.logger.info("User Media API: #{response}")
      if response["media"]["data"].present?
        response["media"]["data"].map { |media| media["media_info"] = fetch_media_info(media["id"]) }
      end
      session[:user_name] = response["username"]
      session[:media_count] = response["media_count"]
      redirect_to controller: 'home', action: 'index',  user_media: response 
    else 
      redirect_to controller: 'home', action: 'index',  user_media: nil
    end


  end

  private 

    def fetchAccessToken(auth_code) 
      params = {app_id: APP_ID, app_secret: APP_SECRET, grant_type: GRANT_TYPE, redirect_uri: REDIRECT_URI, code: auth_code}
      response = Curl.post(ACCESSTOKEN_URL, params)
      return JSON.parse(response.body_str)
    end

    def fetch_media_info(media_id)
    #   curl "https://graph.instagram.com/18040303081200401?fields=username,media_type,media_url,thumbnail_url,caption,timestamp,username&access_token=IGQVJYNmNzLW1aUktUNDB5VWhkMXZAZANVhTRzE1dU5FMndOeVp1SmVtLXNwd3R2LUhIQXF0emZAaaU9jUnlHamtFRFk1Y2VfMnhFQVRDbklrNnhZAN1FweFExUklra1IzV0JyQUQ0VmpxWjlqdjB2U2tkcElEeW13MDlURzFr" \
    #  -H 'Cookie: ig_did=38414875-9838-473C-840B-86EDA77036DB; mid=XhciFwAEAAF8thXkjOeuVG2r_cTr; csrftoken=ztG7KambkZyLS1w0rTwlWRockB5afC22; rur=ASH'

    # {
    #   "username": "chsai.btech",
    #   "media_type": "CAROUSEL_ALBUM",
    #   "media_url": "https:\/\/scontent.xx.fbcdn.net\/v\/t51.2885-15\/71264636_162963184778828_3734323487569382918_n.jpg?_nc_cat=108&_nc_oc=AQlViqI7AM3L5ijzhTa8QJoed7jYIYrlo1Y7E6VAF9R--6SkDPHI4LW53ROxIWbP_8U&_nc_ht=scontent.xx&oh=141cba2e78583b0f8dec9f8c0044ced8&oe=5E9F31C7",
    #   "caption": "Welcome to the most beautiful planet on universe... Saisya.",
    #   "timestamp": "2019-10-20T14:11:00+0000",
    #   "id": "18040303081200401"
    # }

    user_media_url = "https://graph.instagram.com/#{media_id}?access_token=#{session[:access_token]}&fields=username,media_type,media_url,thumbnail_url,caption,timestamp"
    raw_response = Curl.get(user_media_url)
    Rails.logger.info("Media API: #{JSON.parse(raw_response.body_str)}")
    return JSON.parse(raw_response.body_str)

    end

end
