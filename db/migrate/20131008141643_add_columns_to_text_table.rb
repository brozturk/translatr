class AddColumnsToTextTable < ActiveRecord::Migration
  create_table :texts do |t|
    t.text :text
    t.string :title
    t.integer :user_id
  end
end
