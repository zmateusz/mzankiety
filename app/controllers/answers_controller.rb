class AnswersController < ApplicationController

  def index
    @answers = Answer.all
  end

  def create
    @poll = Poll.find(params[:poll_id])
    @answer = @poll.answers.create(answer_params)
    redirect_to poll_path(@poll)
  end

  def destroy
    @answer = Answer.find(params[:id]) 
    @answer.destroy
    if params[:poll] != nil
      redirect_to poll_path(params[:poll])
    else
      redirect_to answers_path
    end
  end

  def wipe
    Answer.delete_all
  end
 
  private
    def answer_params
      params.require(:answer).permit(:option)
    end
end
