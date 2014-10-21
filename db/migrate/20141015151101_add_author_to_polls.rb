class AddAuthorToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :author, :string
  end
end
