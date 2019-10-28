Rails.application.routes.draw do

devise_for :users
get '/dashboard', to: 'users#dashboard'
post '/project/:project_id/resource/:resource_id', to:'projectcodes#assignresource' ,as:'assign_resource_project'
delete '/deleteuser/:user_id/project/:project_id', to: 'projectcodes#removeuser', as: 'deleteuser_project'
get '/users/:user_id/addResource/:project_id', to: 'projectcodes#getallusers' ,as:'get_all_users'
post '/users/:user_id/project/:project_id/bugs/:id/assign_bug', to:'bugs#assignbugtodeveloper' ,as:'assign_project_developer_bug'
post '/users/:user_id/project/:projectcode_id/bugs/:id/mark_bug', to:'bugs#markasreolved' ,as:'mark_project_bug_resolved'

  resources :users,only:[] do
    resources :projectcodes do
      resources :bugs
    end
  end
   

root to: 'users#dashboard'
end
