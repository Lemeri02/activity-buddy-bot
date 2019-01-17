class User < ApplicationRecord
  validates_uniqueness_of :telegram_id

  def next_bot_command=(command)
    self.bot_command_data[:command] = command
  end

  def next_bot_command
    self.bot_command_data[:command]
  end

end
