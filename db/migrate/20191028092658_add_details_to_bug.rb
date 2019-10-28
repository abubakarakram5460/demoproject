class AddDetailsToBug < ActiveRecord::Migration[5.1]
  def change
    remove_column :bugs, :status
    add_column :bugs, :status, :string
  end
end
