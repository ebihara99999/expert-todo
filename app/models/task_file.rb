class TaskFile < ApplicationRecord
  mount_uploader :attached_file, TaskFileUploader
  
  has_many :file_task_attachments
  has_many :tasks, through: :file_task_attachments
  
  validates :attached_file, presence: true
end
