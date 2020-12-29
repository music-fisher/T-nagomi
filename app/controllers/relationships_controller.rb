class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  def followings
     user = User.find(params[:user_id])
     @users = user.followings
  end

  def followers
     user = User.find(params[:user_id])
     @users = user.followers
  end
#     before_action :set_user
#   def create
#     following = current_user.follow(@user)
#     following.save
#     redirect_back(fallback_location: root_path)
#   end
#   def destroy
#     following = current_user.unfollow(@user)
#     following.destroy
#     redirect_back(fallback_location: root_path)
#   end
 
# private
#   def set_user
#     @user = User.find(params[:user_id])
#   end

end
