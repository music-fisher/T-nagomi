class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(9)
  end
  def edit
    @user = User.find(params[:id])
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを編集しました。"
    redirect_to user_path(@user.id)
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
