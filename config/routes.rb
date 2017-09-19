Rails.application.routes.draw do

  get "/me", to: "users#me"
  get "/users/:id", to: "users#show", as: :user
  get "/collections/:id", to: "collections#show", as: :collection

  scope :badges do
    get "/:id", to: "badges#show", as: :badge

    post "/:id/wish", to: "badges#wish", as: :wish
    post "/:id/unwish", to: "badges#unwish", as: :unwish

    post "/:id/inventory", to: "badges#inventory", as: :inventory
  end

  scope :trades do
    get "/", to: "trades#index", as: :trades
    get "/:id", to: "trades#show", as: :trade

    post "/", to: "trades#create", as: :create_trade
    post "/:id", to: "trades#update", as: :update_trade
  end

  root to: "collections#index"
end
