#encoding: utf-8
class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy, :vote, :results]

  # GET /polls
  # GET /polls.json
  def index
    #@polls = Poll.order(:id).page params[:page]
    @polls = Poll.order(created_at: :desc)#.where(:survey_id => nil) #:shared => true
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
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
    if cookies["poll_#{@poll.id}"] == "voted"
      redirect_to @poll, notice: 'Nie możesz ponownie głosować!' and return
    end
    @polls = Poll.order(:id).page params[:page]
    #@vote = Vote.new
    @ans = [] 
    @poll.answers.each do |answer| 
      @ans.push(answer.option)
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
    @poll = Poll.find(params[:id])
    case @poll.typ
    when "Radio"
      @ans = @poll.answers
      @n = @poll.answers.sum(:counter).to_i
    when "Checkbox"
      @votes = Vote.where(:poll_id => @poll.id)
      @count = @votes.count
    when "Text"
      @votes = Vote.where(:poll_id => @poll.id)
      @count = @votes.count
    else
      puts "no type"
    end
  end

  # POST /polls
  # POST /polls.json
  def create
    #render plain: params.inspect
    @poll = Poll.new(poll_params)
    if params[:survey_id] != nil then @poll.survey_id = params[:survey_id] end
    if current_user == nil
      @poll.author = "anonim"
    else
      @poll.author = current_user.username
    end
    respond_to do |format|
      if @poll.save
        format.html { 
          if params[:survey_id] != nil
            redirect_to detail_survey_path(params[:survey_id]), notice: 'Poll was successfully created.'
          else
            redirect_to @poll, notice: 'Poll was successfully created.' 
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
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
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
      format.html { redirect_to :back, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def togglep
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
  end

  def enddate
    detail
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
    @poll.update_attribute(:ends_at, new_date)
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
