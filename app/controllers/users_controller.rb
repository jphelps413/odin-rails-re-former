class UsersController < ApplicationController

  def new
    logger.debug {"User#new"}
  end

  def create
    @user = User.new(username: params[:username],
                     email:    params[:email],
                     password: params[:password])
=begin
    @user = User.new(user_params)
=end
    if @user.save
      redirect_to new_user_path
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end
