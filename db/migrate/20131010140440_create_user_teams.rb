class CreateUserTeams < ActiveRecord::Migration
  def change
    create_table :user_teams do |t|
      t.integer :user_id
      t.integer :team_id
      t.string :state
    end
  end
end
