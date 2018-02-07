require "rails_helper"

RSpec.describe "Tasks", type: :system, js: true do
  context do
    let(:user) { create :user, :sign_up }

    before do
      login(user)
    end

    it "creates new task" do
      puts("in creates new task")
      click_link "タスク一覧"

      click_link "タスクの新規作成"

      find("#task_task_name").set "資料の作成"
      find("#app > div > main > div > div > div > div.card__actions > button > div").click

      sleep 3 # TODO: This is required to pass the test!!!

      expect(Task.count).to eq 1
    end
  end

  context do
    let(:task) { create :task }

    before do
      login(task.user)
    end

    it "updates task and changes the task done" do
      click_link "タスク一覧"
      find("#app > div > main > div > div > div > table > tbody > tr > td:nth-child(1) > a").click # 編集ボタン押下

      find("#task_task_name").native.clear
      find("#task_task_name").set "変更後のタスク名"

      find("#task_task_description").set "変更後のタスク詳細"
      find("#app > div > main > div > div > div > div.card__actions > button > div").click # 更新ボタン押下
      sleep 3 # TODO: This is required to pass the test!!!

      expect(Task.find_by(task_name: "変更後のタスク名")).not_to be_nil
      expect(Task.find_by(description: "変更後のタスク詳細")).not_to be_nil

      click_link "タスク一覧"
      find("#app > div > main > div > div > div > table > tbody > tr > td:nth-child(7) > button > div").click

      sleep 3 # TODO: This is required to pass the test!!!
      expect(Task.where(is_done: true).count).to eq 1
    end
  end
end
