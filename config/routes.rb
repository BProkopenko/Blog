Rails.application.routes.draw do
	root to: 'pages#home'
	get 'moderation/new_posts'
  get 'moderation/pending'
  get 'home' => 'pages/home'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
	get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
	post 'create_comment' => 'posts#create_comment'
	delete 'delete_comment' => 'comments#destroy'
	resources :users
	resources :posts
	resources :topics
	resources :moderation, only: [:update]
	resources :account_activations , only: [:edit]
  resources :admin, only: [:index,:update, :destroy]
	resources :password_resets, only: [:new, :create, :edit, :update]
end
