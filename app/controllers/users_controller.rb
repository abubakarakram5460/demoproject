class UsersController < ApplicationController
  before_action :getdata, only: [:showassignedcreators, :showassigneddevelopers]

    def dashboard
         @projects=current_user.projectcodes;
         if(current_user.type=="Manager")
            @totalprojectcreators=Userproject.gettotalcreators(@projects)
            @totalprojectdevelopers=Userproject.gettotaldevelopers(@projects)
         else 
              @totalbugs=current_user.bugs.count
         end   
    end
    def showassignedcreators
        @creators=User.get_assigned_creators(@projects)
    end  
    def showassigneddevelopers
        @developers=User.get_assigned_developers(@projects)
    end  
    def getdata
        @user=User.getuser(params[:user_id])
        @projects=User.get_manager_projects(@user)
    end

end
