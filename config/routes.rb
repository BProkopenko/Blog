Rails.application.routes.draw do
  get 'sessions/new'

	get 'signup' => 'users#new'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

	resources :users

	root to: 'sessions#new'

	resources :account_activations , only: [:edit]

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
