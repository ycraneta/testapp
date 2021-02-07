Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :posts do
    member do
      get 'like_lists'
    end
  end
  post 'like', to: 'posts#like'
  post 'like_cancel', to: 'posts#like_cancel'
end
