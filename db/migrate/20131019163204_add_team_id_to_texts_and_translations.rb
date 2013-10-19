class AddTeamIdToTextsAndTranslations < ActiveRecord::Migration
  def change
    add_column :texts, :team_id, :integer
    add_column :translations, :team_id, :integer
  end
end
