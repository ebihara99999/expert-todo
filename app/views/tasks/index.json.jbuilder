json.set! :tasks do
  json.array!(@tasks) do |task|
    json.extract! task, :id, :user_id, :task_name, :description, :due_date
  end
end
