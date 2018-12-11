Rails.application.routes.draw do
  devise_for :users,  :skip => [:registrations]
  as :user do
    get 'users/edit' => 'registrations#edit', :as => 'edit_user_registration'    
    put 'users' => 'registrations#update', :as => 'user_registration'            
  end
  root 'welcome#index' 
  
  get '/dashboard' => 'users#index', as: :user_index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
