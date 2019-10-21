class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # enum type: [:Manager, :Developer, :Creator]
  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.type ||= :Manager
  # end  


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   
         has_many :userprojects
         has_many :projectcodes ,:through => :userprojects


end
