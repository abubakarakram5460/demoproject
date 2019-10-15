class AddUsertypeToUserproject < ActiveRecord::Migration[5.1]
  def change
    add_column :userprojects, :usertype, :string 
  
  end
end
