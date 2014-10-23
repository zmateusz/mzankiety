class Poll < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :votes, :through => :answers
end

