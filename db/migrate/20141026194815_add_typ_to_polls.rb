class AddTypToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :typ, :string
  end
end
