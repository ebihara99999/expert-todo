require "rails_helper"

RSpec.describe "TaskFiles", type: :system do
  context do
    let(:user) { create :user }

    before do
      login_as user, scope: :user
    end

    it "uploads files", js: true do
      # pending "Fix later"
      create(:task, user_id: user.id)
      visit "/tasks"

      click_link "ファイルを添付"

      attach_file "attachment_file_to_task", Rails.root.join("spec", "support", "task_files", "konaki.jpg")
      attach_file "attachment_file_to_task", Rails.root.join("spec", "support", "task_files", "test1.txt")

      page.execute_script "window.scrollBy(0,5000)"

      page.accept_alert(wait: 8) do
        click_button "Submit image"
      end

      expect(TaskFile.count).to eq 2
      expect(FileTaskAttachment.count).to eq 2
      expect(page).to have_content "konaki.jpg"
      expect(page).to have_content "test1.txt"
    end
  end
end
