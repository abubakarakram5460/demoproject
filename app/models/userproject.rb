class Userproject < ApplicationRecord
    validates_uniqueness_of :user_id, scope: :projectcode_id
    belongs_to :projectcode
    belongs_to :user

end
