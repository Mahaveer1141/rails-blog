class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[destroy]
  before_action :validate_destroy_comment, only: %i[destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post.id)
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment.destroy
    redirect_to post_path(@post.id), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def validate_destroy_comment
    return unless @comment.user.id != current_user.id

    redirect_to post_path(params[:post_id])
  end
end
