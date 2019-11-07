class UserPolicy < ApplicationPolicy
    attr_reader :current_user, :record

    def initialize(current_user,record)
        @current_user=current_user
        @record=record
    end 
  
    def index?
        current_user.id==record.id
    end
    def showspecificbugs?
        current_user.id==record.id  
    end 
       

    def dashboard?
    #   @current_user.is_a?(Manager)
    # @user=User.find(6)
    # authorize @user
    end   
end   