class CreateTaskFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :task_files do |t|
      t.string :attached_file, null: false
      t.timestamps
    end
  end
end
