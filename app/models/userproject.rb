class Userproject < ApplicationRecord
    validates_uniqueness_of :user_id, scope: :projectcode_id
    belongs_to :projectcode
    belongs_to :user

    def self.gettotalcreators(projects)
       @totalcreator=0
        projects.each do |project|
        @totalcreator=@totalcreator+project.userprojects.where(usertype:"Creator").count
        puts "in creator"
        puts @totalcreator
        end
        @totalcreator
      end
      def self.gettotaldevelopers(projects)
        @totaldevelopers=0
        projects.each do |project|
            puts "in developer"
         @totaldevelopers= project.userprojects.where(usertype:"Developer").count+@totaldevelopers
        puts @totaldevelopers
        end
        @totaldevelopers
       end



end
