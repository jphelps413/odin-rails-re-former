class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
=begin
    @user = User.new(username: params[:username],
                     email:    params[:email],
                     password: params[:password])
=end
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # Seems like more work than necessary to avoid losing an existing
    # password, but I can't see any other obvious way to do it. Besides,
    # this needs a password confirmation, but didn't feel like setting it
    # up right at this time.
    if params[:user][:password].length == 0
       params[:user][:password] = @user.password
    end
    #binding.pry
    if @user.update(user_params)
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  def index
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end
