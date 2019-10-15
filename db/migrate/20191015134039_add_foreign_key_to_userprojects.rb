class AddForeignKeyToUserprojects < ActiveRecord::Migration[5.1]
  def change
    add_reference :userprojects, :projectcode, foreign_key: true
    add_reference :userprojects, :user, foreign_key: true
  end
end
