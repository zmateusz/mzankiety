class AddVotableToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :votable, :boolean, :null => false, :default => false
    add_column :surveys, :private, :boolean, :null => false, :default => false
    add_column :surveys, :password, :string, :null => true, :default => nil
  end
end
