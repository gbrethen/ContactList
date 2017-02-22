Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: 'application#angular'
    
    resources :contacts
    
    get "contacts" => "contacts#index"
    post "contacts" => "contacts#create"
    delete "contacts" => "contacts#destroy"
end
