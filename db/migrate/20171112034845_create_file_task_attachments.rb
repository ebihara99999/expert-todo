class CreateFileTaskAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :file_task_attachments do |t|
      t.references :task, null: false, foreign_key: true, index: true
      t.references :task_file, null: false, foreign_key: true, index: true
      t.timestamps
    end
    add_index :file_task_attachments, [:task_id, :task_file_id], unique: true
  end
end
