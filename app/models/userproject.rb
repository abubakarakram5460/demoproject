class Userproject < ApplicationRecord
    validates_uniqueness_of :user_id, scope: :projectcode_id
    
    belongs_to :projectcode
    belongs_to :user

    def self.get_total_creators(projects)
      User.joins(:projectcodes).where(projectcodes:{id: projects.all.ids }, type: "Creator").uniq.count
    end

    def self.get_total_developers(projects)
      User.joins(:projectcodes).where(projectcodes:{id: projects.all.ids }, type: "Developer").uniq.count
    end

    def self.get_project_user(id)
      @user=Userproject.find_by(user_id: id)
    end
     
    def self.removeprojectuser(id)
      @userproject=Userproject.find(id).destroy
    end    
end
