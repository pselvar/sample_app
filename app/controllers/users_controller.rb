class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  def new
      @title = "Sign Up"
  end
  
  def show
      @user = User.find(params[:id])
      @title = @user.name
  end
end
