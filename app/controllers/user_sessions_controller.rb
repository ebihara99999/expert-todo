class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    if @user = login(params[:email], params[:password])
      hoge
      redirect_to root_path
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end
  
  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end
end