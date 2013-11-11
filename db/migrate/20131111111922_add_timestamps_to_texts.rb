class AddTimestampsToTexts < ActiveRecord::Migration
  def change
    add_column(:texts, :created_at, :datetime)
    add_column(:texts, :updated_at, :datetime)
  end
end
