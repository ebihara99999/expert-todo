json.set! :task_files do
  json.array!(@task_files) do |task_file|
    json.extract! task_file, :id, :attached_file, :created_at, :updated_at
    json.set! :filename, task_file.attached_file.file.filename
  end
end
