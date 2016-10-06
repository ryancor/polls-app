Rails.application.routes.draw do
	resources :polls
	resources :users, only: [:show]
	resources :votes, only: [:create]

	root to: 'polls#index'

	# Search params
	get 'search', to: 'search#search'
	
	# Facebook login
	get '/auth/:provider/callback', to: 'sessions#create'
	get '/auth/failure', to: 'sessions#auth_fail'
	get '/sign_out', to: 'sessions#destroy', as: :sign_out
end
