class Activity < ApplicationRecord
  belongs_to :user

  scope :with_user, ->(user) { where(user: user) }
  scope :today, -> { where(date: Date.today) }
  scope :last_n_days, ->(n) { where(date: (Date.today - n)..(Date.today))}
end
