module Api
  module V1
    module Users
      class RegistrationsController < ApplicationController
        def new
        end

        def create
          @user = User.new(user_params(params))
          if @user.save
            render :index, formats: "json", handlers: "jbuilder", status: :created
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end

        private

          def user_params(params)
            params.require(:user).permit(:email, :password, :password_confirmation)
          end
      end
    end
  end
end
