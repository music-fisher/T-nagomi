class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def index
  end

  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
    tag_list = params[:tag_name].split(",")
  if @post.save
      @post.save_post(tag_list)
  end
    
  end
  
  def edit
  end
  def update
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :body, :kind, :post_image)
  end
end
