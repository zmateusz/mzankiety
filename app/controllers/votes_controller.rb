class VotesController < ApplicationController

  def index
    @votes = Vote.order(answer_id: :asc)    
  end

  def create
    #render plain: params[:vote].inspect
    @answer = Answer.find(params[:vote])
    @vote = @answer.votes.create("author" => current_user.username, "poll_id" => params[:poll_id])
    redirect_to poll_path(params[:poll_id])
  end

  def destroy
    @vote = Vote.find(params[:id]) 
    @vote.destroy
    redirect_to votes_path
  end

  private
  def vote_params
    params.require(:vote).permit(:poll_id)
  end
end
