class WelcomeController < ApplicationController
  def index
    require_login
  end
end
