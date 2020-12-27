class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def index
    @posts = Post.all.includes(:user)
    @tag_list = Tag.all
  end
  def bookmarks
    @posts = current_user.bookmark_posts.includes(:user)
  end

  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(",")
    if @post.save
        @post.save_post(tag_list)
    redirect_to post_path(@post)
    end

  end

  def edit
  end
  def update
  end
  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])#クリックしたタグの情報取得
    @posts = @tag.posts.all#タグに紐づく投稿
    # @user = User.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :kind, :post_image)
  end
end
