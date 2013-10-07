class ChangeDefaultBooleeanInUsersTable < ActiveRecord::Migration
  def change
    change_column_default :user, :translator, :boolean, :default => false
  end
end
