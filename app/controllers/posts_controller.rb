class PostsController < ApplicationController
  before_action :require_login, only: [:create, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post Created!"
    else
      render "new"
    end
  end

  def show
  end

  def edit
    @post = current_user.posts.find(params[:id])
    if !@post 
      redirect_to action: "show", id: :id, notice: "No access"
    end
  end

  def update
    @post = current_user.posts.build(post_params)
    if @post.update_attributes(post_params)
      redirect_to @post, notice: "Post Updated!"
    else
      render "new"
    end
  end
  
  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
  
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
