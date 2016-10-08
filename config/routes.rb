Rails.application.routes.draw do
	resources :polls
	resources :votes, only: [:create]

	root to: 'polls#index'

	# Search params
	get 'search', to: 'search#search'

	get '/users/:id', to: 'users#show', as: 'user'
	get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
	post '/users/:id', to: 'users#update'
	
	# Facebook login
	get '/auth/:provider/callback', to: 'sessions#create'
	get '/auth/failure', to: 'sessions#auth_fail'
	get '/sign_out', to: 'sessions#destroy', as: :sign_out
end
