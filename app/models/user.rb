class User < ActiveRecord::Base
  scope :that_is_not_a_translator, -> { where(translator: false) }
  scope :that_is_a_translator, -> { where(translator: true) }

  before_create :create_remember_token

  has_many :teams,  -> { where user_teams: { state: 'accepted' } }, through: :user_teams
  has_many :translations, dependent: :destroy
  has_many :user_teams, dependent: :destroy
  has_many :texts, dependent: :destroy

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

  def send_password_reset_info
    self.password_reset_token = User.new_remember_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end

