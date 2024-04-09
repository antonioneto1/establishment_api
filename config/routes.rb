Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :establishments
      resources :owners
      #post '/lectures/owners', to: 'owners#create', as: 'create'
    end
  end
end
