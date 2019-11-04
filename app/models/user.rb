class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # def set_default_role
  #   self.type ||= :Manager
  # end  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   
         has_many :userprojects
         has_many :projectcodes ,:through => :userprojects
 
    def self.get_all_developers_excluding_specificproject(project)
        User.all.where.not(id:project.users.ids,type:["Creator","Manager"])  
    end
   
    def self.get_all_creators_excluding_specificproject(project)
        User.all.where.not(id:project.users.ids,type:["Developer","Manager"])  
    end

    def self.get_manager_projects(user)
        user.projectcodes   
    end
    
    def self.getallcreators(project)
        project.users.where(:type => "Creator")    
    end
    
    def self.getalldevelopers(project)
        project.users.where(:type => "Developer")
    end
    
    def self.getuser(id)
       @user= User.find(id)
    end
    
    def self.get_assigned_creators(projects)
        @creator=[]
        projects.each do |project|
        @creators=project.users.where(:type=>"Creator")
            @creators.each do |creator|
                @creator.push(creator)
            end
        end  
        @creator=@creator.uniq
    end 
    def self.get_assigned_developers(projects)
        @developer=[]
        projects.each do |project|
            @developers=project.users.where(:type=>"Developer")
            @developers.each do |developer|
                @developer.push(developer)
            end
        end  
        @developer=@developer.uniq
    end      
end
