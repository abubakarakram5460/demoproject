class AddCompositkeyToUserproject < ActiveRecord::Migration[5.1]
  def change
    add_index :userprojects, [:projectcode_id, :user_id], unique: true
  end
end
