class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @survey = Survey.where(shared: true).last 
    @poll = Poll.where(survey_id: nil, shared: true).last
  end
  
  def inside
    @surveys = Survey.order(created_at: :desc).where(:author => current_user.username)
    @polls = Poll.order(created_at: :desc).where(:author => current_user.username, :survey_id => nil)
  end 
    
end
