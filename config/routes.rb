Rails.application.routes.draw do

  resources :topics do
    #  pass resources :posts to the resources: topics block. this nests posts route under topic route
    resources :posts, except: [:index]
  end
  # => modify about view to allow users to visit /about instead of /welcome/about
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
