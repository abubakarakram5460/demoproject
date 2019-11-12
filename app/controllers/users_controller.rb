class UsersController < ApplicationController
  before_action :get_data, only: [:show_assigned_creators, :show_assigned_developers]

    def dashboard
     @projects=current_user.projectcodes;
     if(current_user.type=="Manager")
       @totalprojectcreators=Userproject.get_total_creators(@projects)
       @totalprojectdevelopers=Userproject.get_total_developers(@projects)
     else 
          @totalbugs=current_user.bugs.count
     end   
    end

    def show_assigned_creators
      @creators=User.get_assigned_creators(@projects)
    end

    def show_assigned_developers
      @developers=User.get_assigned_developers(@projects)
    end

    def get_data
      @user=User.get_user(params[:user_id])
      @projects=User.get_manager_projects(@user)
    end

end
