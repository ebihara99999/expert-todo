require "rails_helper"

RSpec.describe "TaskFiles", type: :request do
  let(:task) { create(:task) }

  before do
    sign_in task.user
  end

  describe "GET /tasks/:id/task_files" do
    it "responses with 200" do
      get "/tasks/#{task.id}/task_files"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /tasks/new" do
    it "responses with 200" do
      get "/tasks/#{task.id}/task_files/new"
      expect(response).to have_http_status(:success)
    end
  end
end
