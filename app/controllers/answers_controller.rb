class AnswersController < ApplicationController

  def index
    @answers = Answer.order(created_at: :desc)
  end

  def create
    @poll = Poll.find(params[:poll_id])
    @poll.answers.create(answer_params)
    redirect_to :back
  end

  def destroy
    @answer = Answer.find(params[:id]) 
    @answer.destroy
    if params[:poll] != nil
      redirect_to :back
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
