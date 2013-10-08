class CreateTeamsTable < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :leader_id
    end
  end
end
