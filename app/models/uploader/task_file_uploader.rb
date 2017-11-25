module Uploader
  class TaskFileUploader
    def upload_files(task_id, uploaded_files)
      TaskFile.transaction do
        uploaded_files.compact!
        task_files = []
        uploaded_files.each do |uploaded_file|
          task_files << TaskFile.create!(attached_file: uploaded_file)
        end
        file_task_attachments = task_files.map { |task_file| FileTaskAttachment.new(task_file_id: task_file.id, task_id: task_id) }

        result = FileTaskAttachment.import file_task_attachments, all_or_none: true

        raise BulkInsertError, "ファイル添付に失敗しました" unless result.failed_instances.empty?
      end
      true
    rescue => e
      unless e.respond_to? :record
        # Bulkinsertのエラーの場合
        # TODO: エラー処理の実装
      end
      false
    end
  end

  class BulkInsertError < StandardError
  end
end
