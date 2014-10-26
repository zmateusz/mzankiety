class RemoveTypeFromPolls < ActiveRecord::Migration
  def change
    remove_column :polls, :type, :string
  end
end
