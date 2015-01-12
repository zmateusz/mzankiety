class AddEndsAtToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :ends_at, :datetime, :null => true, :default => nil
  end
end
