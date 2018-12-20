Rails.application.routes.draw do
  devise_for :users,  :skip => [:registrations]
  as :user do
    get 'users/edit' => 'registrations#edit', :as => 'edit_user_registration'    
    put 'users' => 'registrations#update', :as => 'user_registration'            
  end
  namespace :admin do
    get '/' => 'users#index', as: :user_index
    resources :event_series, only: [:new, :create]
    resources :events, only: [:edit, :update]
  end
  root 'welcome#index' 
  scope '/:slug/' do
    get '/' => 'events#index'
  end 
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
