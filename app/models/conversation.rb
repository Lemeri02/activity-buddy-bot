class Conversation < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  scope :with_messages, -> { includes(:messages) }

  CONVERSATION_TIMEOUT = 5.minutes

  def timed_out?
    return false if messages.empty?
    last_message.time <= (DateTime.now - CONVERSATION_TIMEOUT)
  end

  def last_message
    messages.last_message.first
  end

  def add_message_from_wit_response(response)
    self.messages.create(time: DateTime.now, text: response.text, intents: response.intents)
  end

end
