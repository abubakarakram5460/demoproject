class RemoveForeignkeyToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :users, :projectcodes
  end
end
