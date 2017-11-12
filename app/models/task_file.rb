class TaskFile < ApplicationRecord
  has_many :file_task_attachments
  has_many :tasks, through: :file_task_attachments
  
  validates :attached_file, presence: true
end
