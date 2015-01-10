class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @polls = Poll.count
    @votes = Vote.count
    @users = User.count
    @survey = Survey.last    
    @poll = Poll.where(:survey_id => nil).last
  end
  
  def inside
    @surveys = Survey.order(created_at: :desc).where(:author => current_user.username)
    @polls = Poll.order(created_at: :desc).where(:author => current_user.username)
  end 
    
end
