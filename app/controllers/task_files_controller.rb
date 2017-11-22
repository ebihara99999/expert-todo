class TaskFilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @task_files = current_user.tasks.find(params[:task_id]).task_files
  end

  def create
    Uploader::TaskFileUploader.new.
      upload_files(params[:task_id],
                   [params[:task_file0],
                    params[:task_file1],
                    params[:task_file2]])
  end

  private

    def task_files_params(params)
      params.permit(:task_file0, :task_file1, :task_file2)
    end

    def task_id_params(params)
      params.permit(:task_id)
    end
end
