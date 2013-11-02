class Translation < ActiveRecord::Base
  after_create :send_creation_notification
  after_update :send_update_notification

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
  
  def send_update_notification
    MemberMailer.translation_update_notification(self).deliver
  end

end
