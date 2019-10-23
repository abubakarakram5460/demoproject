class ChangeColumnnameToBug < ActiveRecord::Migration[5.1]
  def change
    change_column :bugs, :deadline, 'timestamp USING CAST(deadline AS timestamp)'
  end
end
