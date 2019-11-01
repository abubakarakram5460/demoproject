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
