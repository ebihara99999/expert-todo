module Api
  module V1
    module Tasks
      class TaskEndsController < ApplicationController
        before_action :jwt_require_auth

        def create
          @task = Task.find(params[:id])
          @task.is_done = true
          if @task.save
            redirect_to api_v1_tasks_path, notice: "#{@task.task_name}を終了済みに変更しました"
          else
            render api_v1_tasks_path
          end
        end
      end
    end
  end
end
