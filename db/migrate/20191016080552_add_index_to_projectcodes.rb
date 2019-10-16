class AddIndexToProjectcodes < ActiveRecord::Migration[5.1]
  def change
  
    add_index :projectcodes, :name, unique: true
  
  end
end
