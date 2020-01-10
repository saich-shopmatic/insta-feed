class HomeController < ApplicationController

  def index
    @access_token = request.params[:access_token]
    @user_id = request.params[:user_id]
    @user_media = request.params[:user_media]
  end

end
