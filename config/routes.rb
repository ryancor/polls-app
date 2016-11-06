Rails.application.routes.draw do
  devise_for :admins
	resources :polls
	resources :votes, only: [:create]

	root to: 'polls#index'

	# Search params
	get 'search', to: 'search#search'

	match '/profile', to: 'users#show', via: [:get]
	get '/users/:slug', to: 'users#show', as: 'user'
	get '/users/:slug/edit', to: 'users#edit', as: 'edit_user'
	post '/users/:slug', to: 'users#update'
	get '/users/:slug/manage', to: 'users#manage', as: 'manage_user'
	
	# Facebook login
	get '/auth/:provider/callback', to: 'sessions#create'
	get '/auth/failure', to: 'sessions#auth_fail'
	get '/sign_out', to: 'sessions#destroy', as: :sign_out

	# If route doesn't exist
	get '*path' => redirect('/')
end
