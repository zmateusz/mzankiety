#encoding: utf-8
class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy, :vote, :result]
  before_action :authenticate_user!, only: [:new]
  before_action :check_cookies, only: [:vote]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.where(survey_id: nil, shared: true).order(created_at: :desc)
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    if @poll.ends_at
      if @poll.ends_at < Time.now
        @poll.votable = false
        @poll.save
      end
    end
  end

  # GET /polls/new
  def new
    @poll = Poll.new
    respond_to do |format|
      format.html
      format.js { render json: {success: true, response: Faker::Company.catch_phrase} }
    end
  end

  # GET /polls/1/edit
  def edit
  end

  def vote
    # render plain: params.inspect
    # redirect_to @poll, notice: 'closed' and return unless @poll.votable
    # redirect_to @poll, notice: 'closed' and return unless @poll.password == session[:pass]

    if @poll.password != "" && @poll.private
      redirect_to poll_path(@poll), notice: 'Podaj poprawne hasło aby głosować.' and return if params[:poll].nil?
      if params[:poll][:pass] != @poll.password
        redirect_to poll_path(@poll), notice: 'Podaj poprawne hasło aby głosować.' and return
      else
        session[:pass] = params[:pass]
      end
    end
    if @poll.survey != nil && session["first"] == @poll.id
      if @poll.survey.private && params[:poll][:pass] != @poll.survey.password
        redirect_to survey_path(@poll.survey_id), notice: 'Podaj poprawne hasło aby głosować.' and return
      end
    end

    # @polls = Poll.order(:id).page params[:page]

    if @poll.typ == "Radio"
      @answers = @poll.answers.order(created_at: :asc)
    elsif @poll.typ == "Checkbox"
      @answers = [] 
      @poll.answers.order(created_at: :asc).each do |answer| 
        @answers.push(answer.option)
      end
    end
        
    if @poll.survey_id != nil
      session[:prog] = 1 if session[:prog] == nil
      n = Survey.find(@poll.survey_id).polls.count
      @progress = "#{session[:prog]}/#{n}"
      @pro = (session[:prog].to_f/n*100).round(1)
      session[:prog] += 1
    end
    render layout: 'voting' 
  end

  def result
    @answers = @poll.answers
    @votes = @poll.votes.order(created_at: :desc)
    @count = @votes.count
    #@percent = Hash.new
    #@answers.each {|ans| @percent[ans.id] = (ans.counter.to_f/@count*100).round(1)}
    if @poll.typ == "Checkbox"
      @votes_hash = Hash.new(0)
      @votes.each {|v| @votes_hash[v.custom] += 1}
    end
  end

  # POST /polls
  # POST /polls.json
  def create
    #render plain: params.inspect
    @poll = Poll.new(poll_params)
    @poll.survey_id = params[:survey_id] if params[:survey_id] != nil

    current_user == nil ? @poll.author = "anonim" : @poll.author = current_user.username

    respond_to do |format|
      if @poll.save
        format.html { 
          @poll.answers.create(option: 'custom') if @poll.typ == "Text"
          if params[:survey_id] != nil
            if @poll.typ == "Radio" || @poll.typ == "Checkbox"
              redirect_to detail_poll_path(@poll), notice: 'Pytanie zostało utworzone. Dodaj teraz odpowiedzi.'
            elsif @poll.typ == "Text" || @poll.typ == "Info"
              redirect_to detail_survey_path(params[:survey_id]), notice: 'Pytanie zostało utworzone.'
            end
          else
            redirect_to detail_poll_path(@poll), notice: 'Sonda została utworzona.' 
          end
        }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { 
          if params[:survey_id] != nil
            redirect_to detail_survey_path(params[:survey_id]), notice: 'Nie udalo sie zapisac pytania.'
          else
            render :new
          end
        }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html {
          if @poll.survey_id == nil
            redirect_to detail_poll_path(@poll), notice: 'Sonda została zaktualizowana.'
          else
            redirect_to detail_survey_path(@poll.survey_id), notice: 'Pytanie zostało zaktualizowane.'
          end 
        }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    votes = Vote.where(:poll_id => @poll.id)
    votes.each {|v| v.destroy}
    @poll.destroy
    respond_to do |format|
      format.html { 
        if @poll.survey_id == nil
          redirect_to :back, notice: 'Sonda została usunięta.'
        else
          redirect_to :back, notice: 'Pytanie zostało usunięte.'
        end
      }
      format.json { head :no_content }
    end
  end

  def setshared
    @poll = Poll.find(params[:id])
    if @poll.shared == true 
      @poll.shared = false
      @poll.save
    else
      @poll.shared = true
      @poll.save
    end
    redirect_to :back
  end

  def detail
    @poll = Poll.find(params[:id])
    @link = request.protocol + request.host_with_port + poll_path(@poll)
    @link += "?pass=#{@poll.password}" if @poll.private 
  end

  def enddate
    @poll = Poll.find(params[:id])
    end_date = params[:poll]
    if @poll.ends_at.nil?
      new_date = DateTime.new(end_date["created_at(1i)"].to_i,
                          end_date["created_at(2i)"].to_i,
                          end_date["created_at(3i)"].to_i,
                          end_date["created_at(4i)"].to_i-1, #poprawka do strefy czasowej, inny sposob?
                          end_date["created_at(5i)"].to_i)
    else
      new_date = DateTime.new(end_date["ends_at(1i)"].to_i,
                          end_date["ends_at(2i)"].to_i,
                          end_date["ends_at(3i)"].to_i,
                          end_date["ends_at(4i)"].to_i-1,
                          end_date["ends_at(5i)"].to_i)
    end
    @poll.update_attribute(:votable, false) if new_date < Time.now
    @poll.update_attribute(:ends_at, new_date)
    redirect_to :back
  end

  def setvotable
    @poll = Poll.find(params[:id])
    if @poll.votable == true 
      @poll.votable = false
      @poll.save
    else
      @poll.votable = true
      @poll.save
    end
    redirect_to :back
  end

  def setpassword
    @poll = Poll.find(params[:id])
    @poll.password = params[:poll][:password]
    if params[:poll][:password].empty?
      @poll.private = false
    else 
      @poll.private = true
    end
    @poll.save
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:name, :typ, :descr, :survey_id)
    end
end
