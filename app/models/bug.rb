class Bug < ApplicationRecord
    
  validates :title, presence: true
  validates :status, presence: true
  validates :bugtype, presence: true    
    
    
    attr_accessor :screenshot
    mount_uploader :screenshot,ImageUploader
    belongs_to :projectcode
    validates :title, uniqueness: true
    belongs_to :creator
end
