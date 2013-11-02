class Translation < ActiveRecord::Base
  after_create :send_creation_notification

  belongs_to :user
  belongs_to :team
  belongs_to :text

  validates :text, presence: true
  validates :user_id, presence: true
  validates :text_id, presence: true

  private
  
  def send_creation_notification
    MemberMailer.translation_creation_notification(self).deliver
  end

end
