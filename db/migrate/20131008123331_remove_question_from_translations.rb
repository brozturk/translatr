class RemoveQuestionFromTranslations < ActiveRecord::Migration
  def change
    remove_column :translations, :question
    remove_column :translations, :answer
  end
end
