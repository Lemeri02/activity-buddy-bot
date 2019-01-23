class DialogContext

  attr_accessor :user, :user_intents, :new_day, :current_node, :last_message, :buffered_nodes, :last_user_intents

  def initialize(user)
    @user = user
    @buffered_nodes = []
  end

  def yes_no
    last_message.dig('entities','yes_no')&.first
  end

  def yes?
    yes_no ? yes_no['value'] == 'yes' : nil
  end

  def no?
    yes_no ? yes_no['value'] == 'no' : nil
  end
end