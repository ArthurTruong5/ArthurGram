class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    if @post = Post.create(post_params)
    flash[:success] = "Your post has been created!"
    redirect_to posts_path
    else
    flash.now[:alert] = "Your new post couldn't be created!  Please check the form."
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


end
