require "rails_helper"

RSpec.describe "Tasks", type: :system do
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

      page.accept_alert do
        click_button "Submit image"
        sleep 2
      end

      expect(TaskFile.count).to eq 2
      expect(FileTaskAttachment.count).to eq 2
      expect(page).to have_content "konaki.jpg"
      expect(page).to have_content "test1.txt"
    end

    it "creates new task" do
      visit "/tasks"

      click_link "新規作成"

      within "#new_task" do
        fill_in "タスク名", with: "資料の作成"
        click_button "登録"
      end

      expect(Task.count).to eq 1
    end
  end

  context do
    let(:task) { create :task }

    before do
      login_as task.user, scope: :user
    end

    it "updates task" do
      visit "/tasks"
      within("#task_#{task.id}") { click_link "編集" }
      within "#edit_task_#{task.id}" do
        fill_in "タスク名", with: "変更後のタスク名"
        fill_in "詳細", with: "変更後の詳細"

        click_button "登録"
      end
      expect(Task.find_by(task_name: "変更後のタスク名")).not_to be_nil
      expect(Task.find_by(description: "変更後の詳細")).not_to be_nil
    end

    it "changes task done" do
      visit "/tasks"
      within("#task_#{task.id}") { click_link "終了済みへ変更" }
      expect(Task.where(is_done: true).count).to eq 1
    end

    it "destroy task" do
      visit "/tasks"
      within("#task_#{task.id}") { click_link "削除" }
      expect(Task.count).to eq 0
    end
  end
end
