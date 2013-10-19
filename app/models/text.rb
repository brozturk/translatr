class Text < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_one :translation

  validates :title, presence: true
  validates :text, presence: true
  validates :user_id, presence: true
end
