require "rails_helper"

RSpec.describe Uploader::TaskFileUploader, type: :model do
  describe "upload_files" do
    let(:task) { create(:task) }

    it "creates 2 task_files and 2 file_task_attachments" do
      Uploader::TaskFileUploader.new.upload_files(task.id, mock_uploaded_files)
      expect(TaskFile.count).to eq 2
      expect(FileTaskAttachment.count).to eq 2
    end
  end
end
