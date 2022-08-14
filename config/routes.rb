Rails.application.routes.draw do

  # twitter login
  get '/hello' => 'hello#index'
  get "/:provider/login"  => "sessions#new"
  get "/logout" => "sessions#destroy"
  get "/auth/twitter/callback" => "sessions#create" unless Rails.env.development?
  post "/auth/twitter/callback" => "sessions#create" if Rails.env.development?
  get "/auth/failure" => "sessions#failuer"

  namespace :api, format: 'json' do
    get '/tickets', to: 'tickets#index'
    get '/tickets/search', to: 'tickets#search'
  end
end
