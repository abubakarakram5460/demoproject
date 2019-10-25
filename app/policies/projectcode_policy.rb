class ProjectcodePolicy < ApplicationPolicy
    attr_reader :current_user, :record
   
    def initialize(current_user,record)
        @current_user=current_user
        @record=record
        
    end 
    
    def index?
         @project=Userproject.where("projectcode_id=? and user_id=?",@record.id,current_user.id)
         @project=@project.first
          if (@project&&@project.user_id==current_user.id)
             true            
          end

    end

    def show?
  
        @project=Projectcode.where("manager_id=?",current_user.id)
         @project=@project.first
          if (@project&&@project.manager_id==current_user.id)
             true            
          end
    end
    
    def getallusers?
         @project=Projectcode.where("manager_id=?",current_user.id)
         @project=@project.first
          if (@project&&@project.manager_id==current_user.id)
              true            
          end
    end   
    
    def create?
        @current_user.is_a?(Manager)
    end
    
    def update?
        @current_user.is_a?(Manager)&&@record.manager_id==@current_user.id    
    end  
    def destroy?
        @current_user.is_a?(Manager)&&@record.manager_id==@current_user.id    
    end 
    def assignresource?
        @current_user.is_a?(Manager)&&@record.manager_id==@current_user.id    
    end
    def removeuser?
        @current_user.is_a?(Manager)&&@record.manager_id==@current_user.id  
    end    

end   