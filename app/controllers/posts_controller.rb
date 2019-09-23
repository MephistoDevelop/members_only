class PostsController < ApplicationController
  def new
    @post= Post.new
  end
  def index
    @post = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path
    else
      flash[:danger] = 'Post NOT created'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title,:body)
  end
end
