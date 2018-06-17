class TaskFile < ApplicationRecord
  mount_uploader :attached_file, TaskFileUploader

  has_many :file_task_attachments, dependent: :destroy
  has_many :tasks, through: :file_task_attachments

  validates :attached_file, presence: true

  def download
    client = Aws::S3::Client.new(region: ENV["AWS_REGION"])
    key = attached_file.file.path
    client.get_object(
      bucket: ENV["AWS_S3_BUCKET"],
      key: key,
    ).body.read
  end
end
