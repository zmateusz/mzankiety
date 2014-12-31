class AddSharedToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :shared, :boolean, :null => false, :default => false
  end
end
