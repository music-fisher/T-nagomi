Rails.application.routes.draw do
  root 'homes#top'
  get 'homes/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update,:index]
  resources :posts
  resources :tags do
    get 'posts', to:"posts#search"
  end
end


