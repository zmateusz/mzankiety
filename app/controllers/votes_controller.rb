#encoding: utf-8
class VotesController < ApplicationController
   # before_action :check_cookies, only: [:create]

  def index
    @votes = Vote.order(created_at: :desc)
  end

  def create
    #render plain: params[:vote].inspect
    @poll = Poll.find(params[:poll_id])
    if @poll.typ == "Radio"
      redirect_to vote_poll_path(@poll, pass: @poll.password), notice: 'Musisz zaznaczyć co najmniej jedną odpowiedź.' and return if params[:vote].nil?
    end
    if @poll.typ == "Checkbox"
      redirect_to vote_poll_path(@poll, pass: @poll.password), notice: 'Musisz zaznaczyć co najmniej jedną odpowiedź.' and return if params[:vote][:choices] == [""]
    end
    if current_user == nil
      user = "anonim"
    else
      user = current_user.username
    end

    if @poll.survey_id != nil
      if @poll.id == session["first"]
        if @poll.votes.present?
          @max = @poll.votes.pluck(:voter).uniq.max
          session["voter"] = @max + 1
        else
          session["voter"] = 1
        end
      end
    end

    if @poll.typ == "Radio"
      @answer = Answer.find(params[:vote])
      @answer.counter +=1; @answer.save
      @answer.votes.create(author: user, poll_id: params[:poll_id], custom: @answer.option, voter: session["voter"])
    elsif @poll.typ == "Checkbox"
      @boxes = params[:vote]
      # @boxes[:choices].reject! { |c| c.empty? }
      @text = @boxes[:choices].reject!{|c| c.empty?}.join(', ')
      @boxes[:choices].each do |ans|
        a = Answer.find_by(option: ans, poll_id: @poll.id)
        a.counter += 1
        @answerid = a.id
        a.save
      end
      Vote.create(author: user, poll_id: params[:poll_id], answer_id: @answerid, custom: @text, voter: session["voter"])
    elsif @poll.typ == "Text"
      @answerid = Answer.find_by(poll_id: @poll.id)
      Vote.create(author: user, poll_id: params[:poll_id], answer_id: @answerid.id, custom: params[:vote][:vote], voter: session["voter"])
    end
    cookies["poll_#{@poll.id}"] = { :value => "voted", :expires => 5.years.from_now }
    if @poll.survey_id == nil
      redirect_to poll_path(@poll), notice: 'Dziękuję, głos został zapisany.'
    else
      @next = Poll.where('id > ? AND survey_id = ?', @poll.id, @poll.survey_id).first
      if @next == nil 
        redirect_to survey_path(@poll.survey_id), notice: 'Dziękuję, odpowiedzi zostały zapisane.'
        session[:prog] = nil
      else
        redirect_to vote_poll_path(@next)
      end
    end

  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.poll.typ == "Radio"
      @vote.answer.counter -= 1
      @vote.answer.save 
    end
    if @vote.poll.typ == "Checkbox"
      custom = @vote.custom.split(', ')
      custom.each do |c|
        a = Answer.find_by(option: c, poll_id: @vote.poll_id)
        a.counter -= 1
        a.save
      end
    end
    @vote.destroy
    redirect_to :back
  end

  private
  def is_admin
    redirect_to '/' if current_user == nil || !current_user.admin?
  end

  def vote_params
    params.require(:vote).permit(:poll_id)
  end

end
