class UsersController < ApplicationController
 
    def dashboard
         @projects=current_user.projectcodes;
         if(current_user.type=="Manager")
            @totalprojectcreators=Userproject.gettotalcreators(@projects)
            @totalprojectdevelopers=Userproject.gettotaldevelopers(@projects)
         elsif(current_user.type=="Creator")
               @totalbugs=current_user.bugs.count
         else
               @totalbugs=current_user.bugs.count
         end   
    end
    def showassignedcreators
        @user=User.getuser(params[:user_id])
        @projects=User.get_manager_projects(@user)
        @creators=User.get_assigned_creators(@projects)
       
    end  
    def showassigneddevelopers
      @user=User.getuser(params[:user_id])
      @projects=User.get_manager_projects(@user)
      @developers=User.get_assigned_developers(@projects)

    end  
end
