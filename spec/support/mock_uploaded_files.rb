def mock_uploaded_file_params(file_paths = [])
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

  { task_file0: files[0], task_file1: files[1] }
end
