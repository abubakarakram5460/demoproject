class Change < ActiveRecord::Migration[5.1]
  def change
    change_column :bugs, :status, 'integer USING CAST(status AS integer)'
  end

 
end
