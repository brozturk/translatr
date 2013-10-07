class AddTranslatorFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :translator, :boolean, default => true
  end
end
