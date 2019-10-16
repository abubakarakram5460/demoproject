Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get '/dashboard', to: 'users#dashboard'
delete '/deleteuser/:user_id/project/:project_id', to: 'projectcodes#removeuser', as: 'deleteuser_project'
# root to: 'users#dashboard' 
resources :users do
  resources :projectcodes
end

end
