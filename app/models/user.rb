class User < ActiveRecord::Base
  before_create :create_remember_token

  has_many :translations
  has_many :teams, through: :user_teams
  belongs_to :team
  has_many :texts

  has_secure_password
  
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with:  VALID_EMAIL_REGEX }
  validates :last_name, presence: true 
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def set_as_translator
    self.translator = true
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end

