require "rails_helper"

RSpec.describe "TaskFiles", type: :system, js: true do
  context do
    let(:task) { create :task }

    before do
      login(task.user)
    end

    it "uploads files" do
      # pending "Fix later"
      click_link "タスク一覧"
      click_link "ファイル一覧"
      click_link "ファイルの添付"

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
