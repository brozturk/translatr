class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :question
      t.string :answer
      t.datetime :time_of_answer
      t.integer :user_id
      t.timestamps
    end
  end
end
