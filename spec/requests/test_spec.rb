require "rails_helper"

RSpec.describe "Test", type: :request do
  let(:user) { create(:user) }
  
  before do
    login_user(user, "password")
  end
  
  describe "GET /tasks" do
    it do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
  
end
