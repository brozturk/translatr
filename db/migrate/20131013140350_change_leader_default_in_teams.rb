class ChangeLeaderDefaultInTeams < ActiveRecord::Migration
  def change
    change_column :users, :leader, :boolean , :default => false
  end
end
