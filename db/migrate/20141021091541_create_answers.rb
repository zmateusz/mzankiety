class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :option
      t.references :poll, index: true

      t.timestamps
    end
  end
end
