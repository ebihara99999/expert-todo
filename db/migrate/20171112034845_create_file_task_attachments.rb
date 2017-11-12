class CreateFileTaskAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :file_task_attachments do |t|

      t.timestamps
    end
  end
end
