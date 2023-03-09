class VotesController < ApplicationController
  def upvote
    puts upvoted?
    # Vote.create(post_id: vote_params[:post_id], user_id: current_user.id, value: 1)
    puts 'upvoted'
  end

  def downvote
    puts 'downvoted'
  end

  private

  def upvoted?
    vote = Vote.find_by(post_id: vote_params[:post_id], user_id: 2)
    if vote
      true
    else
      false
    end
  end

  def vote_params
    params.permit(:post_id)
  end
end
