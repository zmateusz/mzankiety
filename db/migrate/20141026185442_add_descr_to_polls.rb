class AddDescrToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :descr, :string
  end
end
