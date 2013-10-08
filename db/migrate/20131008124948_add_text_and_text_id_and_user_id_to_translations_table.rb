class AddTextAndTextIdAndUserIdToTranslationsTable < ActiveRecord::Migration
  def change
    add_column :translations , :text, :text
    add_column :translations, :text_id, :integer
  end
end
