class ChangeAgaincolumnnameToBug < ActiveRecord::Migration[5.1]
  def change
    change_column :bugs, :date, 'timestamp USING CAST(deadline AS timestamp)'
  end
end
