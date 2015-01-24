class AddVoterToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :voter, :integer
  end
end
