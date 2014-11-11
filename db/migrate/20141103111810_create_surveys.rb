class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :descr
      t.string :author

      t.timestamps
    end
  end
end
