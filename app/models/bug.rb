class Bug < ApplicationRecord
  include AASM
  
  enum status: {
    newer: 0,
    started: 1,
    completed: 2,
    resolved: 3
   } 
   
    aasm column: :status, enum: true, whiny_tansitions: false do
     state :newer, initial: true
     state :started
     state :completed
     state :resolved

     event :set_next_state do
       transitions from: :newer , to: :started
     
       transitions from: :started, to: :completed, guard: :feature?
     
       transitions from: :started, to: :resolved, guard: :bug?
     end
   end  
   
    before_create :set_default_value
    
    validates :bugtype, presence: true 
    validates :title, presence: true, uniqueness: true   
    
    
    attr_accessor :screenshot
    mount_uploader :screenshot,ImageUploader
    
    belongs_to :creator
    belongs_to :projectcode
    
    
    scope :get_bug, -> id { find(id) if id.present? }
    scope :get_specificproject_bugs, -> id { where(projectcode_id: id) if id.present? }

    def set_default_value
      self.status="newer"   
    end  
    
    def self.get_specificuser_bugs(user)
      @bugs=user.bugs
    end  
    
    def setbug(id)
      update(developer_id:id)
    end 
    
   def feature?
      bugtype == "feature"
   end

   def bug?
      bugtype == "bug"
   end

 end  
 
