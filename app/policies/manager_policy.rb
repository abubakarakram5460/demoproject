class ManagerPolicy < ApplicationPolicy
    attr_reader :current_user, :record
   
    def initialize(current_user,record)
    @current_user=current_user
    @record=record
    
    end 
     
    def index?
        current_user.id==record.id
    end 
    
    def new?
        current_user.id==record.id&&current_user.is_a?(Manager)
    end
    
    def dashboard?
   
    end   
end   