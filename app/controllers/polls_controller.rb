class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy, :vote, :results]

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  def vote
    #@vote = Vote.new
    @ans = [] 
    @poll.answers.each do |answer| 
      @ans.push(answer.option)
    end 
  end

  def result
    @poll = Poll.find(params[:id])
    @ans = @poll.answers
    @n = @poll.answers.sum(:counter).to_i
  end

  # POST /polls
  # POST /polls.json
  def create
    #render plain: params.inspect
    @poll = Poll.new(poll_params)
    if current_user == nil
      @poll.author = "anonim"
    else
      @poll.author = current_user.username
    end
    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
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
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:name, :typ, :descr)
    end
end
