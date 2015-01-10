class AddEndsAtToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :ends_at, :datetime, :null => false, :default => false
  end
end
