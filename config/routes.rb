Rails.application.routes.draw do

  resources :topics do
    #  pass resources :posts to the resources: topics block. this nests posts route under topic route
    resources :posts, except: [:index]
  end
  # create routes for new and create actions. only hash key will prevent unnecessary routes
  resources :users, only:[:new, :create]
  # => modify about view to allow users to visit /about instead of /welcome/about
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
