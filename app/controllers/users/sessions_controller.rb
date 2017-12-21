module Users
  class SessionsController < DeviseTokenAuth::SessionsController
    protected
    def render_create_success
      @resource_data = resource_data(resource_json: @resource.token_validation_response)
      render "users/sessions/new", formats: "json", handlers: "jbuilder"
    end
  end
end
