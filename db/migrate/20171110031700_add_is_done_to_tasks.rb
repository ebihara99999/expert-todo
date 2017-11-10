class AddIsDoneToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :is_done, :boolean, null: false, default: false
    add_index :tasks, :is_done
  end
end
