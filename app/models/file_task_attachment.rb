class FileTaskAttachment < ApplicationRecord
  belongs_to :task
  belongs_to :task_file

  validates :task_file_id, presence: true, uniqueness: { scope: [:task_id] }
  validates :task_id, presence: true
end
