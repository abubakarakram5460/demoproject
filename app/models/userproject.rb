class Userproject < ApplicationRecord
    validates_uniqueness_of :user_id, scope: :projectcode_id
    belongs_to :projectcode
    belongs_to :user

    def self.gettotalcreators(projects)
        @creator=[]
        projects.each do |project|
        @creators=project.users.where(type: "Creator")
            @creators.each do |creator|
                @creator.push(creator)
            end
        end  
        @totalcreator=@creator.uniq.count
        
    end
    def self.gettotaldevelopers(projects)
        @developer=[]
        projects.each do |project|
        @developers=project.users.where(type: "Creator")
            @developers.each do |developer|
                @developer.push(developer)
            end
        end  
        @totaldevelopers=@developer.uniq.count
          
    end
       
    def self.deletespecificprojectassignusers(project)
          @alluserproject=project.userprojects
          @alluserproject.each do |userproject| 
          userproject.destroy
          end
    end

    def self.getprojectuser(id)
        @user=Userproject.find_by(user_id: id)
    end 
    def self.removeprojectuser(id)
      @userproject=Userproject.find(id)
      @userproject.destroy
    end    
end
