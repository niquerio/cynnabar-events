Rails.application.routes.draw do
  devise_for :users,  :skip => [:registrations]
  as :user do
    get 'users/edit' => 'registrations#edit', :as => 'edit_user_registration'    
    put 'users' => 'registrations#update', :as => 'user_registration'            
  end
  namespace :admin do
    get '/' => 'users#index', as: :user_index
    get '/event_series/new' => 'event_series#new', as: :new_event_series
    post '/event_series' => 'event_series#create'
  end
  root 'welcome#index' 
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
