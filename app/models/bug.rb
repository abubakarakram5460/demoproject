class Bug < ApplicationRecord
    
  validates :title, presence: true
  validates :status, presence: true
  validates :bugtype, presence: true    
    
    
    attr_accessor :screenshot
    mount_uploader :screenshot,ImageUploader
    belongs_to :projectcode
    validates :title, uniqueness: true
    belongs_to :creator
    def self.getspecificuserbugs(user)
      @bugs=user.bugs
    end  
    
    def self.getspecificprojectbugs(id)
     @bugs= Bug.where(:projectcode_id => id)
    end
    def self.getbug(id)
      @bug=Bug.find(id);
    end 
    def self.setstatus(status,bug)
        if status=='resolved'&&bug.status=='newer'
              return 1
        elsif status=='completed'&&bug.status=='newer'
              return 2
        else  
              @bug.assign
              return 0
        end 
    end 
    def self.setbugtype(bug)
        if bug.bugtype=='feature'
            bug.complete
        else
            bug.resolve
        end 
    end
    
    def self.setbug(bug,id)
     @bug.update(developer_id:id)
    end  
    def self.deletespecificprojectbugs(project)
        @specificprojectbugs=Bug.where(projectcode_id:project.id)
        @specificprojectbugs.each do |bug| 
        bug.destroy
        end
    end
    enum status: [:newer , :started , :resolved , :completed] do
      event :assign do
        transition :newer => :started
      end
      event :complete do
        transition :started => :completed 
      end
      event :resolve do
        transition :started => :resolved
      end 
    end  

 end
