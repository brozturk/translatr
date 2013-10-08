class Team < ActiveRecord::Base
  has_and_belongs_to_many(:users)
  has_many :texts, through: :users
  has_many :translations, through: :users

  validates :name, presence: true
end
