class PostsController < ApplicationController
  def show
  end

  def index
  end

  def new
    @post = Post.new
  end
  def create
    @post = Post.new
    if @post.user_id == current_user.id
      @post.save(post_params)
      redirect_to post_path(@post)
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
