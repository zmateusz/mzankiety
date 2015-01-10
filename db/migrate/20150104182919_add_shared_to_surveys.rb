class AddSharedToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :shared, :boolean, :null => false, :default => false
  end
end
