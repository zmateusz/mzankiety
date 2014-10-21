class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :author
      t.references :answer, index: true
      t.references :poll, index: true

      t.timestamps
    end
  end
end
