FactoryGirl.define do
  factory :task_file do
    attached_file { Rack::Test::UploadedFile.new Rails.root.join("spec", "support", "task_files", "konaki.jpg"), "image/jpg" }
  end
end
