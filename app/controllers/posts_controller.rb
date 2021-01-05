class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @posts = Post.all.includes(:user).page(params[:page]).per(8)
    @comment = Comment.new
  end

  def index
    @posts = if params[:kind].present?
               Post.where(kind: params[:kind]).includes(:user).page(params[:page]).per(8)
             else
               Post.all.includes(:user).page(params[:page]).per(8)
             end
    @tag_list = Tag.all
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
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
  def rank
    # @all_ranks = Post.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
  @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :kind, :post_image, :user_id)
  end
end
