class Projectcode < ApplicationRecord
    before_save :set_default_value
    
    validates :name, presence: true, uniqueness: true
    
    has_many :bugs, dependent: :destroy
    has_many :userprojects, dependent: :destroy
    has_many :users, :through => :userprojects
    belongs_to :manager
    
    scope :get_project, -> id { find(id) if id.present? }
  
    def set_default_value
      if self.name.blank?
          self.name=nil
      end   
    end
 

end
