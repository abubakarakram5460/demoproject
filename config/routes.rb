Rails.application.routes.draw do
 

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get '/dashboard', to: 'users#dashboard'
post '/project/:project_id/resource/:resource_id', to:'projectcodes#assignresource' ,as:'assign_resource_project'
delete '/deleteuser/:user_id/project/:project_id', to: 'projectcodes#removeuser', as: 'deleteuser_project'
get '/users/:user_id/allusers/:project_id', to: 'projectcodes#getallusers' ,as:'get_all_users'
# root to: 'users#dashboard' 
resources :users do
  resources :projectcodes do
    resources :bugs
end
end

end
