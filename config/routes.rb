Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    scope module: :v1 do
      resources :user, only: [:create]
      resources :authentication, only: [:create]

      get "/quotes/authors", to: "quotes#authors"
      get "/quotes/terms", to: "quotes#terms"
      get "/quotes/:search_tag", to: "quotes#search_tag"
    end
  end
end
