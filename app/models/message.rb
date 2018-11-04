class Message < ApplicationRecord

  enum status: {
    received_by_server: 'received_by_server',
    sent_to_recipient: 'sent_to_recipient',
    seen_by_recipient: 'seen_by_recipient'
  }

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :contentable, polymorphic: true, optional: true

  before_validation :init

  validates_presence_of :sender_id, :recipient_id, :content, :status, :channel, :message_display_id

  private

  def generate_channel_name
    [sender_id, recipient_id].sort.join('_') if sender_id && recipient_id
  end

  def init
    self.channel ||= generate_channel_name
    self.message_display_id ||= Digest::SHA256.hexdigest(self.channel.to_s)
    self.status ||= :received_by_server
  end
end
