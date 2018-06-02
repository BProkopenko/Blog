Rails.application.routes.draw do

  get 'moderation/new_posts'

  get 'moderation/pending'

  resources :moderation, only: [:update]

  get 'home' => 'pages/home'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

	get 'signup' => 'users#new'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

	resources :users

  resources :admin

	root to: 'pages#home'

	resources :account_activations , only: [:edit]

	resources :password_resets, only: [:new, :create, :edit, :update]

  resources :posts

  post 'create_comment' => 'posts#create_comment'

  delete 'delete_comment' => 'comments#destroy'

	resources :topics


	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
