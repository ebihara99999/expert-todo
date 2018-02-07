require "rails_helper"

RSpec.describe "Tasks", type: :request do
  let(:task) { create(:task, :due_date) }

  before do
    token = jwt_of task.user
    @headers = {
      "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": token
    }
  end

  describe "GET /tasks" do
    before { get api_v1_tasks_path, headers: @headers }
    
    let(:task_response) do
      {
        id: Integer,
          user_id: Integer,
          task_name: String,
          description: String,
          due_date: String,
          created_at: String,
      }
    end
    it "responses with 200" do
      expect(response).to have_http_status(200)
    end

    it do
      expect(response.body).to be_json_including(tasks: [task_response])
    end
  end
  
  describe "GET /tasks/new" do
    before { get new_api_v1_task_path, headers: @headers }
    
    it "responses with 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /tasks/:id/edit" do
    before { get edit_api_v1_task_path(task.id), headers: @headers }
    
    it "responses with 200" do
      expect(response).to have_http_status(200)
    end
  end
end
