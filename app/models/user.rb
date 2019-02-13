class User < ApplicationRecord
  has_many :conversations, dependent: :destroy
  has_many :messages, through: :conversations
  has_many :activities, dependent: :destroy
  validates_uniqueness_of :telegram_id


  def self.create_from_message!(from)
    user = User.find_or_initialize_by(telegram_id: from['id'])
    user.firstname = from['first_name']
    user.save!
    user
  end

end
