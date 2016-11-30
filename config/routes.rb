Rails.application.routes.draw do

  resources :topics do
    #  pass resources :posts to the resources: topics block. this nests posts route under topic route
    resources :posts, except: [:index]
  end

  # use only: [] because we dont want to create posts/:id routes, just posts/:post_id/comments routes
  resources :posts, only: [] do
    # only create and destroy routes. the show view is through the posts show view.
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]

    # create POST routes at the url posts/:id/up-vote or down-vote....the as tells it that it will be the path up_vote_path
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  # create routes for new and create actions. only hash key will prevent unnecessary routes
  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]

  # => modify about view to allow users to visit /about instead of /welcome/about
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
