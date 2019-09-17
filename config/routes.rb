Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :olympians, only: [:index]
      get 'olympian_stats', to: 'olympian_stats#index'
    end
  end
end
