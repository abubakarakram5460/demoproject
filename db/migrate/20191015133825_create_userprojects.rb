class CreateUserprojects < ActiveRecord::Migration[5.1]
  def change
    create_table :userprojects do |t|
        
      t.timestamps
    end
  end
end
