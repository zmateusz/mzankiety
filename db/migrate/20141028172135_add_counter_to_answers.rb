class AddCounterToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :counter, :integer
  end
end
