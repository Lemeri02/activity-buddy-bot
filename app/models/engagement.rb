class Engagement < ApplicationRecord

  def to_h
    self.slice(:strategy, :score, :metrics)
  end
end
