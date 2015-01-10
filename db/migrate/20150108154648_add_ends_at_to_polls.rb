class AddEndsAtToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :ends_at, :datetime, :null => false, :default => false
  end
end
