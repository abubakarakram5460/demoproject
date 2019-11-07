class ProjectcodePolicy < ApplicationPolicy
    attr_reader :current_user, :record
   
    def initialize(current_user,record)
        @current_user=current_user
        @record=record
    end 
    
    def index?
        User.joins(:projectcodes).where(projectcodes:{id: record.id }, type: "Creator").ids.include?(current_user.id)
    end

    def show?
        current_user.id==record.manager_id            
    end
    
    def getallusers?
        current_user.id==record.manager_id 
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