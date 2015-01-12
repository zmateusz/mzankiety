class AddEndsAtToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :ends_at, :datetime, :null => true, :default => nil
  end
end
