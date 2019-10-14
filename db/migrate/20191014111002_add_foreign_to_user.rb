class AddForeignToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :projectcode, foreign_key: true
  end
end
