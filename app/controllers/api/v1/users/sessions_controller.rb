module Api
  module V1
    module Users
      class SessionsController < ApplicationController
        def new
        end
      
        def create
          render json: jwt_auth(session_params(params)[:email], session_params(params)[:password])
        end
      
        private
      
          def session_params(params)
            params.require(:session).permit(
              :email,
                :password,
            )
          end
      end
    end
  end
end
