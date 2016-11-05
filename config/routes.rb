Rails.application.routes.draw do
  # => resources method, pass it a Symbol. creates post routes for creating, updating, viewing, deleting instances of post
  resources :posts

  # => modify about view to allow users to visit /about instead of /welcome/about
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
