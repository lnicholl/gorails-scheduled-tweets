# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  # GET /about (about controller, and index action)
  get "/about", to: "about#index"

  # get "/" = root request
  # get "/", to: "main#index"
  root to: "main#index"
end
