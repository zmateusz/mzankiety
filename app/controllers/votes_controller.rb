class VotesController < ApplicationController
  # before_action :is_admin, only: [:index]

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
    elsif @poll.typ == "Text"
      @vote = Vote.new("author" => user, "poll_id" => params[:poll_id], "custom" => params[:vote][:vote])
      @vote.save
    end
    cookies["poll_#{@poll.id}"] = { :value => "voted", :expires => 5.years.from_now }
    if @poll.survey_id == nil
      redirect_to result_poll_path(params[:poll_id])
    else
      @next = Poll.where('id > ?', params[:poll_id]).first
      if @next == nil 
        redirect_to votes_path
        session[:prog] = nil
      elsif @poll.survey_id != @next.survey_id
        redirect_to votes_path
        session[:prog] = nil
      else
        redirect_to vote_poll_path(@next)
      end
    end

  end

  def destroy
    @vote = Vote.find(params[:id]) 
    @vote.answer.counter = @vote.answer.counter - 1
    @vote.answer.save 
    @vote.destroy
    #redirect_to votes_path
    respond_to do |format|
      format.html { render :nothing => true }
      format.js   { render :nothing => true }
    end
  end

  private
  def is_admin
    redirect_to '/' if current_user == nil || !current_user.admin?
  end

  def vote_params
    params.require(:vote).permit(:poll_id)
  end
end
