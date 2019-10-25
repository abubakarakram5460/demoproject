class DeveloperPolicy < ApplicationPolicy
    attr_reader :current_user, :record
   
    def initialize(current_user,record)
    @current_user=current_user
    @record=record
    
    end 
     
     def index?
      current_user.id==record.id
   
     end 
   
   
    def dashboard?
   
    end   
   end   