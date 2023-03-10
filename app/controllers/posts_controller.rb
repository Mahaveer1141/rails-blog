class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_vote, only: %i[upvote downvote]
  before_action :set_post, only: %i[edit update destroy show]
  before_action :validate_edit_post, only: %i[edit update destroy]
  before_action :set_post_per_page, :set_post_count, :set_current_page, only: :index
  before_action :validate_page, only: :index

  def index
    @posts = Post.order(created_at: :desc).offset((@current_page - 1) * @posts_per_page).limit(@posts_per_page)
  end

  def new
    @post = Post.new
  end

  def show; end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, status: :see_other
  end

  def upvote
    if @vote
      if @vote.value == -1
        @vote.update(value: 1)
      else
        @vote.destroy
      end
    else
      Vote.create(post_id: vote_params[:post_id], user_id: current_user.id, value: 1)
    end
    redirect_to post_path(vote_params[:post_id])
  end

  def downvote
    if @vote
      if @vote.value == 1
        @vote.update(value: -1)
      else
        @vote.destroy
      end
    else
      Vote.create(post_id: vote_params[:post_id], user_id: current_user.id, value: -1)
    end
    redirect_to post_path(vote_params[:post_id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def vote_params
    params.permit(:post_id)
  end

  def set_vote
    @vote = Vote.find_by(post_id: vote_params[:post_id], user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

  def validate_edit_post
    return unless @post.user.id != current_user.id

    redirect_to post_path(@post.id)
  end

  def set_post_per_page
    @posts_per_page = 4
  end

  def set_post_count
    @count = Post.count
  end

  def set_current_page
    @current_page = if params.key? :page
                      params[:page].to_i
                    else
                      1
                    end
  end

  def validate_page
    total_pages = (@count + @posts_per_page - 1) / @posts_per_page
    return unless total_pages < @current_page

    redirect_to root_path(page: total_pages)
  end
end
