Rails.application.routes.draw do
  get '/login' => 'github#redirect_to_github'
  get '/callback' => 'github#callback'
end
