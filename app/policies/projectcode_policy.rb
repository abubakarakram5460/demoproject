class ProjectcodePolicy < ApplicationPolicy
    attr_reader :current_user, :record
   
    def initialize(current_user,record)
        @current_user=current_user
        @record=record
    end 
    
    def index?
       
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