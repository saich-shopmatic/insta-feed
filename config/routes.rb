Rails.application.routes.draw do


  match 'oauth/connect', to: 'instagram#connect', via: [:get]
  match 'oauth/callback/', to: 'instagram#callback', via: [:all]


    #Callback URL
    #match '/oauth/callback/'
    #Autorize URL
    #match '/oauth/connect/'
    #/user_recent_media
    #/user_media_feed

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

end
