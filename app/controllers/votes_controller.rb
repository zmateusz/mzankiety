class VotesController < ApplicationController

  def index
    @votes = Vote.order(created_at: :asc)    
  end

  def create
    #render plain: params[:vote].inspect

    if current_user == nil
      user = "anonim"
    else
      user = current_user.username
    end

    @poll = Poll.find(params[:poll_id])
    if @poll.typ == "Radio"
      @answer = Answer.find(params[:vote])
      @answer.counter +=1
      @answer.save
      @vote = @answer.votes.create("author" => user, "poll_id" => params[:poll_id])
      redirect_to poll_path(params[:poll_id])
    else
      @vote = Vote.new("author" => user, "poll_id" => params[:poll_id], "custom" => params[:vote])
      @vote.save
      redirect_to poll_path(params[:poll_id])
    end
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
