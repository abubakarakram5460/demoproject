class UsersController < ApplicationController
 before_action :authenticate_user!

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


end
