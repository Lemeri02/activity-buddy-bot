class Message < ApplicationRecord
  belongs_to :conversation
  has_one :user, through: :conversation

  scope :last_message, -> { order( time: :desc ).limit(1) }


end
