module Api
  module V1
    class TaskFilesController < ApplicationController
      before_action :jwt_require_auth

      def index
        @task_files = current_user.tasks.find(params[:task_id]).task_files
        render :index, formats: "json", handlers: "jbuilder"
      end

      def show
        task_file = TaskFile.find(params[:id])
        downloaded_file = task_file.download
        send_data downloaded_file, filename: task_file.attached_file.file.filename
      end

      def create
        result = Uploader::TaskFileUploader.new(params[:task_id], task_files_params(params)).upload_files
        if result
          render :index, formats: "json", handlers: "jbuilder"
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      private

        def task_files_params(params)
          params.permit(:task_file0, :task_file1, :task_file2, :task_file3, :task_file4)
        end
    end
  end
end
