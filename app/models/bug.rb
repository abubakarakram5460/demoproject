class Bug < ApplicationRecord
  
    before_create :set_default_value

    validates :title, presence: true
    validates :bugtype, presence: true    
    
    
    attr_accessor :screenshot
    mount_uploader :screenshot,ImageUploader
    belongs_to :projectcode
    validates :title, uniqueness: true
    belongs_to :creator
    
    scope :getbug, -> id { find(id) if id.present? }
    scope :getspecificprojectbugs, -> id { where(projectcode_id: id) if id.present? }

    def set_default_value
        self.status="newer"   
    end  
    
    def self.getspecificuserbugs(user)
        @bugs=user.bugs
    end  
    
    def self.setstatus(status,bug)
        if status=='resolved' && bug.status=='newer'
              return 1
        elsif status=='completed' && bug.status=='newer'
              return 2
        else  
              bug.assign 
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
        bug.update(developer_id:id)
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
