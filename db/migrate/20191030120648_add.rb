class Add < ActiveRecord::Migration[5.1]
  def change
    add_reference :bugs, :projectcode, foreign_key: true
  end
end
