class Engagement < ApplicationRecord

  scope :with_user, ->(user_id) { where(user_id: user_id) }
  scope :with_strategy, ->(strategy) { where(strategy: strategy) }
  scope :by_date, -> { order(created_at: :desc) }
  scope :today, -> { where(created_at: Date.today) }

  def self.for_conversation(conversation_id)
    Engagement.where(conversation_id: conversation_id).sum(:score)
  end

  def to_h
    self.slice(:strategy, :score, :metrics)
  end
end
