class AddSurveyToPolls < ActiveRecord::Migration
  def change
    add_reference :polls, :survey, index: true
  end
end
