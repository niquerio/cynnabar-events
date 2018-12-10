Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index' 
  
  get '/dashboard' => 'users#index', as: :user_index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
