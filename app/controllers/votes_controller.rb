class VotesController < ApplicationController

  def index
    @votes = Vote.order(created_at: :desc)    
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
      @vote = @answer.votes.create("author" => user, "poll_id" => params[:poll_id], "custom" => @answer.option)
    elsif @poll.typ == "Checkbox"
      @boxes = params[:vote]
      @text =""
      @boxes[:choices].reject! { |c| c.empty? }
      @boxes[:choices].each {|x| @text += x + ","}
      @vote = Vote.new("author" => user, "poll_id" => params[:poll_id], "custom" => @text)
      @vote.save
    else
      @vote = Vote.new("author" => user, "poll_id" => params[:poll_id], "custom" => params[:vote])
      @vote.save
    end

    if @poll.survey_id == nil
      redirect_to result_poll_path(params[:poll_id])
    else
      @po = Poll.where('id > ?', params[:poll_id]).first
      if @po == nil 
        redirect_to votes_path
      else
        redirect_to vote_poll_path(@po)
      end
    end

    #redirect_to poll_path(params[:poll_id])
    #redirect_to votes_path
    #
    # !KOD NA PRZEKIEROWANIE DO NASTEPNEGO PYTANIA!
    #
    # @po = Poll.where('id > ?', params[:poll_id]).first
    # if @po == nil 
    #   redirect_to votes_path
    # else
    #   redirect_to vote_poll_path(@po)
    # end
  end

  def destroy
    @vote = Vote.find(params[:id]) 
    @vote.destroy
    #redirect_to votes_path
    respond_to do |format|
      format.html { redirect_to(votes_path) }
      format.js   { render :nothing => true }
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:poll_id)
  end
end
