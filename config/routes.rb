Rails.application.routes.draw do
	get '/' => 'editor#edit', :constraints => lambda { |r| r.cookies['login'].present? }
  root to: 'pages#index'
  get '/login' => 'github#redirect_to_github'
  get '/callback' => 'github#callback'
	get '/editor' => 'editor#editor'
	post '/save' => 'editor#save'
end
