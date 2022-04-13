Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # twitter login
  get "/hello" => "hello#index"
  get "/:provider/login"  => "sessions#new"
  get "/logout" => "sessions#destroy"
  get "/auth/twitter/callback" => "sessions#create" unless Rails.env.development?
  post "/auth/twitter/callback" => "sessions#create" if Rails.env.development?
  get "/auth/failure" => "sessions#failuer"
end
