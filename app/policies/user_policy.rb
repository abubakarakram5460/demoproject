class UserPolicy
 attr_reader :current_user, :model

 def initialize(current_user,model)
 @current_user=current_user
 @user=model
 
 end 
 
 def dashboard?
#   @current_user.is_a?(Manager)
# @user=User.find(6)
# authorize @user
 end   
end   