class AddCustomToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :custom, :string
  end
end
