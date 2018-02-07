module Api
  module V1
    class TasksController < ApplicationController
      before_action :jwt_require_auth
      before_action :load_task, only: [:edit, :update, :destroy]
      
      def index
        @tasks = current_user.tasks
        render :index, formats: "json", handlers: "jbuilder"
      end
      
      def new
        @task = Task.new
        @task.user_id = current_user.id
        
        render :new, formats: "json", handlers: "jbuilder"
      end
      
      def create
        @task = Task.new(task_params(params))
        @task.user_id = current_user.id
        
        if @task.save
          render :index, formats: "json", handlers: "jbuilder"
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end
      
      def edit
        render :edit, formats: "json", handlers: "jbuilder"
      end
      
      def update
        @task.assign_attributes(task_params(params))
        if @task.save
          # redirect_to tasks_path, notice: "タスクを更新しました", status: :ok
          render :index, formats: "json", handlers: "jbuilder"
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end
      
      def destroy
        @task.destroy!
        redirect_to tasks_path, notice: "タスクを削除しました"
      end
      
      private
      
      def task_params(params)
        params.require(:task).permit(
          :task_name,
            :description,
            :due_date,
        )
      end
      
      def load_task
        @task = current_user.tasks.find_by(id: params[:id])
      end
    end
  end
end
