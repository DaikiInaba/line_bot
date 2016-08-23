Rails.application.routes.draw do

  post 'callback' => 'application#callback'
  resources :keywords, only: [:new, :create]

end
