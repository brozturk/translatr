class Translation < ActiveRecord::Base
  belongs_to :user
  belongs_to :text

  validates :text, presence: true
  validates :user_id, presence: true
  validates :text_id, presence: true

end
