Rails.application.routes.draw do
  root 'homes#top'
  get 'homes/about'
  get '/mypage' => 'users#mypage'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update,:index] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :posts, shallow: true do
    resource :bookmarks, only: [:create, :destroy]
    get :bookmarks, on: :collection
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :tags do
    get 'posts', to:"posts#search"
  end
end


