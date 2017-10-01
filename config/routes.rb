Rails.application.routes.draw do
  namespace :admin do
    resources :badges
    resources :categories
    resources :collections
    resources :inventories
    resources :trades
    resources :trade_badges
    resources :users
    resources :wishes

    root to: "badges#index"
  end

  get "/me", to: "users#me", as: :me
  patch "/me", to: "users#update"

  get "/users/:id", to: "users#show", as: :user
  get "/collections/:id", to: "collections#show", as: :collection
  get "/categories/:id", to: "categories#show", as: :category
  get "/search", to: "badges#search", as: :search

  get "/login", to: "users#login_page", as: :login_page
  post "/login", to: "users#login", as: :login

  get "/register", to: "users#register_page", as: :register_page
  post "/register", to: "users#register", as: :register

  delete "/logout", to: "users#logout", as: :logout

  scope :badges do
    get "/:id", to: "badges#show", as: :badge

    post "/:id/wish", to: "badges#wish", as: :wish
    post "/:id/unwish", to: "badges#unwish", as: :unwish
    post "/:id/inventory", to: "badges#inventory", as: :inventory
  end

  scope :trades do
    get "/:id", to: "trades#show", as: :trade
    post "/", to: "trades#create", as: :create_trade
  end

  get "/pages/:page", to: "pages#show", as: :pages

  root to: "collections#index"
end
