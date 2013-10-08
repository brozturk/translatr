class Text < ActiveRecord::Base
  belongs_to :user
  has_one :translation

  validates :title, presence: true
  validates :text, presence: true
  validates :user_id, presence: true
end
