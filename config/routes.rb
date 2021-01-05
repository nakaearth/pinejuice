Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # twitter login
  get "/:provider/login"  => "sessions#new"
  get "/logout" => "sessions#destroy"
  get "/auth/:provider/callback" => "sessions#create" unless Rails.env.development?
  post "/auth/:provider/callback" => "sessions#create" if Rails.env.development?
  get "/auth/failure" => "sessions#failuer"
end
