class Bug < ApplicationRecord
    belongs_to :projectcode
    validates :title, uniqueness: true
    belongs_to :creator
end
