class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @posts = Post.all.includes(:user).page(params[:page]).per(9)
  end

  def index
    @posts = Post.all.includes(:user).page(params[:page]).per(9)
    @tag_list = Tag.all
    # kind検索@post必要ない？？
    # @post = Post.find(params[:id])
  end
  # ブックマークの一覧
  def bookmarks
    @tag_list = Tag.all
    @posts = current_user.bookmark_posts.includes(:user).page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(/,|、/)
    if @post.save
        @post.save_post(tag_list)
        redirect_to post_path(@post)
    else
        render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    @user = @post.user.id
    redirect_to user_path(@user)
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])#クリックしたタグの情報取得
    @posts = @tag.posts.all.page(params[:page]).per(5)#タグに紐づく投稿
    # @user = User.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :kind, :post_image, :user_id)
  end
end
