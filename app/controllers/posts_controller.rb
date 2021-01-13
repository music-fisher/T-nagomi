class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @posts = Post.all.includes(:user).page(params[:page]).per(5)
    @comment = Comment.new
    @user = User.find(@post.user_id)
  end

  def index
    @posts = if !@search_posts.nil?
               @search_posts
             elsif params[:kind].present?
               Post.where(kind: params[:kind]).includes(:user).page(params[:page]).per(5)
             else
               Post.all.includes(:user).page(params[:page]).per(5)
             end

    @tag_list = Tag.all
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
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
        redirect_to posts_path
        flash[:success]="投稿に成功しました。"
    else
        render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
    @tag_list =@post.tags.pluck(:tag_name).join(",")
  end
  def update
    @post = Post.find(params[:id])
    @user = @post.user.id
    tag_list = params[:post][:tag_name].split(/,|、/)
    if @post.update(post_params)
        @post.save_post(tag_list)
        flash[:notice]="投稿を更新しました。"
        redirect_to user_path(@user)
    else
      flash[:alart]="投稿の更新に失敗しました。"
      render 'edit'
    end
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
       flash[:success]="投稿を削除しました。"
      redirect_to posts_path
    else
       flash[:alert]="投稿の削除に失敗しました。"
      render 'show'
    end
  end
  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])#クリックしたタグの情報取得
    @posts = @tag.posts.all.page(params[:page]).per(5)#タグに紐づく投稿
  end

  def rank
    @all_ranks = Post.ranking.page(params[:page]).per(5)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :kind, :post_image, :user_id)
  end
end
