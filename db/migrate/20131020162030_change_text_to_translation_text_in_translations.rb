class ChangeTextToTranslationTextInTranslations < ActiveRecord::Migration
  def change
    rename_column :translations, :text, :translation_text
  end
end
