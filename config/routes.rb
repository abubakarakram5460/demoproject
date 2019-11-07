Rails.application.routes.draw do

devise_for :users
get '/dashboard', to: 'users#dashboard'
post '/project/:id/resource/:user_id', to:'projectcodes#assignresource' ,as:'assign_resource_project'
delete '/deleteuser/:user_id/project/:id', to: 'projectcodes#removeuser', as: 'deleteuser_project'
get '/users/:user_id/addResource/:id', to: 'projectcodes#getallusers' ,as:'get_all_users'
post '/users/:user_id/project/:project_id/bugs/:id/assign_bug', to:'bugs#assignbugtodeveloper' ,as:'assign_project_developer_bug'
post '/users/:user_id/project/:projectcode_id/bugs/:id/mark_bug', to:'bugs#markasreolved' ,as:'mark_project_bug_resolved'
get '/users/:user_id/bugs',to:'bugs#showspecificbugs' ,as:'show_specific_bugs'
get '/users/:user_id/assigned_qa',to:'users#showassignedcreators' ,as:'show_specific_creator'
get '/users/:user_id/assigned_developer',to:'users#showassigneddevelopers' ,as:'show_specific_developer'
  resources :users,only:[] do
    resources :projectcodes , :path=>'projects' do
      resources :bugs
    end
  end
   

root to: 'users#dashboard'
end
