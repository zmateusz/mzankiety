class Survey < ActiveRecord::Base
  has_many :polls, dependent: :destroy
end
