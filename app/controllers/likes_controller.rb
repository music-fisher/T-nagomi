class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save
    # 通知機能追加
    if @post.user != current_user
     @post.create_notification_by(current_user)
    end
    redirect_to request.referrer
  end
  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end
end
