def mock_uploaded_files(file_paths = [])
  file_paths << Rails.root.join("spec", "support", "task_files", "konaki.jpg")
  file_paths << Rails.root.join("spec", "support", "task_files", "test1.txt")

  files = []
  file_paths.each do |file_path|
    files << ActionDispatch::Http::UploadedFile.new(
      filename: File.basename(file_path),
      type: "text/plain",
      tempfile: File.open(file_path),
    )
  end

  files
end
