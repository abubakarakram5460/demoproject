class CreateBugs < ActiveRecord::Migration[5.1]
  def change
    create_table :bugs do |t|
      t.string :title,  :unique=>true
      t.string :deadline
      t.string :date
      t.string :screenshot, :null => true
      t.string :type
      t.string :status
      t.string :descryption, :null => true
      t.timestamps
    end
  end
end
