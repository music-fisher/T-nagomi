class UsersController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(9)
  end
  def edit
    @user = User.find(params[:id])
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:update] = "You have updated user info successfully."
    redirect_to user_path(@user.id)
    # else
    #   render  :new
    end
  end
  end
  def index
    @users = User.all
  end
  def mypage
    redirect_to user_path(current_user)
  end

  private
  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction, :email)
  end
end
