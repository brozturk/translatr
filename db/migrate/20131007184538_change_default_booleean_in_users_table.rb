class ChangeDefaultBooleeanInUsersTable < ActiveRecord::Migration
  def change
    change_column :users, :translator, :boolean, :default => false
  end
end
