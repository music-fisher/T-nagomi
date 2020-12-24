class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]= "会員情報を更新しました。"
    redirect_to user_path(@user.id)
    end
  end
  end
  def index
  end

  private
  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction, :email)
  end
end
