# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :signed_in_only!, only: %i[new create]

  def new
    @post = Post.new
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

  def signed_in_only!
    redirect_to sign_in_path unless logged_in?
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
