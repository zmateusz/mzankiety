class VotesController < ApplicationController
  def create
    render plain: params[:vote].inspect
end
end
