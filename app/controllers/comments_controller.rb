class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    p @comment
    @comment.destroy
    redirect_to post_path(@post.id), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
