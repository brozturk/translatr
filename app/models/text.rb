class Text < ActiveRecord::Base
  scope :latest, -> { order(created_at: :desc).limit(5) } 

  after_create :send_notification_email
  after_update :send_update_notification
  
  belongs_to :user
  belongs_to :team
  has_one :translation, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true
  validates :user_id, presence: true

  private

  def send_notification_email
    MemberMailer.text_creation_notification(self).deliver
  end

  def send_update_notification
    MemberMailer.text_update_notification(self).deliver
  end
end
