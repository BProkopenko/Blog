Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

	get 'signup' => 'users#new'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

	resources :users

	root to: 'sessions#new'

	resources :account_activations , only: [:edit]

	resources :password_resets, only: [:new, :create, :edit, :update]

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
