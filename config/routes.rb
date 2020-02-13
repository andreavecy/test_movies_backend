Rails.application.routes.draw do

  resources :movies
  get 'date_range', to: 'movies#date_range'
end
