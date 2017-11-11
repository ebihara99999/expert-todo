class TaskStatesController < ApplicationController
  before_action :authenticate_user!
  def update
    @task = Task.find(params[:id])
    @task.is_done = true
    if @task.save
      redirect_to tasks_path, notice: "#{@task.task_name}を終了済みに変更しました"
    else
      render :tasks_path
    end
  end
end
