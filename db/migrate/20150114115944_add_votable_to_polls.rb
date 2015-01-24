class AddVotableToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :votable, :boolean, :null => false, :default => false
    add_column :polls, :private, :boolean, :null => false, :default => false
    add_column :polls, :password, :string, :null => true, :default => nil
  end
end
