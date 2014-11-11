class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @polls = Poll.count
    @votes = Vote.count
    @users = User.count
  end
  
  def inside
  end 
    
end
