class CommentsController < ApplicationController
before_action :set_post

    def create
      @comment = @post.comments.new(comment_params)
      @comment.user_id = current_user.id


      if @comment.save
        logger.info"test"
        respond_to do |format|
        format.html { redirect_to post_index_path, anchor: @post }
        format.js
        logger.info"test"
        end
      else
        flash[:alert] = "Check the comment form, something went horribly wrong."
        render post_index_path
      end
    end


    def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:alert] = "Comment Deleted."
    redirect_to post_index_path
    end

  private

  def comment_params
  params.require(:comment).permit(:content)
  end

  def set_post
  @post = Post.find(params[:post_id])
  end




end
