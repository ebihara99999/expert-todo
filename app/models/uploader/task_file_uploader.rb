module Uploader
  class TaskFileUploader
    attr_accessor :task_id, :files, :files_count
    def initialize(task_id, *args)
      @task_id = task_id
      @files_count = args[0].keys.count

      files_count.times do |i|
        class_eval("attr_accessor :task_file#{i}")
        send("task_file#{i}=", args[0][:"task_file#{i}"])
      end
    end

    def upload_files
      TaskFile.transaction do
        task_files = []
        files_count.times do |i|
          task_files << TaskFile.create!(attached_file: send("task_file#{i}"))
        end

        file_task_attachments = task_files.map {|task_file| FileTaskAttachment.new(task_file_id: task_file.id, task_id: task_id) }

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
