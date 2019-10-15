class Projectcode < ApplicationRecord
    
    has_many :userprojects
    has_many :users ,:through => :userprojects
    belongs_to :manager
    has_many :bugs
end
