class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # def set_default_role
  #   self.type ||= :Manager
  # end  
  scope :get_user, -> id { find(id) if id.present? }
  scope :get_all_creators, -> project { project.users.where(type: "Creator")  }
  scope :get_all_developers, -> project { project.users.where(type: "Developer")  }
  scope :get_manager_projects, -> user { user.projectcodes  }

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
     
    def self.get_assigned_creators(projects)
      User.joins(:projectcodes).where(projectcodes:{id: projects.all.ids }, type: "Creator").uniq
    end 
    def self.get_assigned_developers(projects)
      User.joins(:projectcodes).where(projectcodes:{id: projects.all.ids }, type: "Developer").uniq
    end      
end
