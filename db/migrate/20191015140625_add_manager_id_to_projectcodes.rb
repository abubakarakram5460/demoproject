class AddManagerIdToProjectcodes < ActiveRecord::Migration[5.1]
  def change
    add_column :projectcodes, :manager_id, :integer
  end
end
