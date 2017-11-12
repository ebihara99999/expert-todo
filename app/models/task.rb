class Task < ApplicationRecord
  belongs_to :user
  has_many :task_files, through: :file_task_attachments
  has_many :file_task_attachments

  validates :user_id, presence: true
  validates :task_name, presence: true
end
