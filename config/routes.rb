Rails.application.routes.draw do
  get "/me", to: "users#me"
  get "/users/:id", to: "users#show", as: :user
  get "/collections/:id", to: "collections#show", as: :collection
  get "/categories/:id", to: "categories#show", as: :category

  get "/login", to: "users#login_page", as: :login_page
  post "/login", to: "users#login", as: :login

  get "/register", to: "users#register_page", as: :register_page
  post "/register", to: "users#register", as: :register

  delete "/logout", to: "users#logout", as: :logout

  scope :badges do
    get "/:id", to: "badges#show", as: :badge
    get "/:id/image", to: "badges#image", as: :badge_image

    post "/:id/wish", to: "badges#wish", as: :wish
    post "/:id/unwish", to: "badges#unwish", as: :unwish
    post "/:id/inventory", to: "badges#inventory", as: :inventory
  end

  scope :trades do
    get "/:id", to: "trades#show", as: :trade
    post "/", to: "trades#create", as: :create_trade
  end

  root to: "collections#index"
end
