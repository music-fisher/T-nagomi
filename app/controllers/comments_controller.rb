class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(@post.user_id)
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @post_tags = @post.tags
    if @comment.save
      # 通知機能
      if @user != current_user
        @comment.post.create_notification_comment!(current_user, @comment.id)
      end
      flash[:notice]="コメントを投稿しました。"
      # render 'posts/show'
    else
      flash[:alert]="コメントの投稿に失敗しました。"
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.destroy
       flash[:success]="コメントを削除しました。"
    else
      flash[:alert]="コメントの削除に失敗しました。"
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
