class BugPolicy < ApplicationPolicy
    attr_reader :current_user, :record
   
    def initialize(current_user,record)
        @current_user=current_user
        @record=record
    end 
    
    def index?
       
    end
    
    def create?
        @current_user.is_a?(Creator)
    end
    
    def update?
        @current_user.is_a?(Creator)&&@record.creator_id==current_user.id    
    end

    def destroy?
        @current_user.is_a?(Creator)&&@record.creator_id==current_user.id    
    end
    
    def assignbugtodeveloper?
        @current_user.is_a?(Developer)  
    end 
    def markasreolved?  
        @current_user.is_a?(Creator)&&record.developer_id==current_user.id
        true
    end
end   