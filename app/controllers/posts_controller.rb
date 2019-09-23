class PostsController < ApplicationController
  def new
    @post= Post.new
  end
  def index
    @post = Post.all
  end
  def create
    @post=Post.new(post_params)
    if @post.save
     # redirect_to @post
      flash.now[:invalid]="No se puede Guardar el post"
    else
      flash.now[:invalid]="No se puede Guardar el post"
    end
  end
  def show
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit :title,:body
  end
end
