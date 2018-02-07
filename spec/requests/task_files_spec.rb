require "rails_helper"

RSpec.describe "TaskFiles", type: :request do
  let(:task) { create(:task) }

  before do
    token = jwt_of task.user
    @headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token,
    }
  end

  describe "GET /tasks/:id/task_files" do
    before do
      get api_v1_task_task_files_path(task_id: task.id), headers: @headers
    end

    it "responses with 200" do
      expect(response).to have_http_status(200)
    end
  end
end
