class AddLeaderFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :leader, :boolean
    add_column :users, :leader_of_team, :integer
  end
end
