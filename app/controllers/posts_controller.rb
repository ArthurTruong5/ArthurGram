class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
      end
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post = Post.find(params[:id])
    flash[:success] = "Post updated."
    @post.update(post_params)
    redirect_to(post_path(@post))
    flash.now[:alert] = "Update failed.  Please check the form."
    else
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def owned_post
    @post = Post.find(params[:id])
    unless current_user == @post.user
    flash[:alert] = "That post doesn't belong to you!"
    redirect_to post_index_path
    end
  end


end
