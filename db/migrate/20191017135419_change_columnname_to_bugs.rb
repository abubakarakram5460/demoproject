class ChangeColumnnameToBugs < ActiveRecord::Migration[5.1]
  def change
    rename_column :bugs, :type, :bugtype

  end
end
