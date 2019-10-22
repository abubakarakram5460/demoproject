class UsersController < ApplicationController
 before_action :authenticate_user!

def dashboard
 @projects=current_user.projectcodes;
 @totalprojectcreators=Userproject.gettotalcreators(@projects)
 @totalprojectdevelopers=Userproject.gettotaldevelopers(@projects)
end    


end
