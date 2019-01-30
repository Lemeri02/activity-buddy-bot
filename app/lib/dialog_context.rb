class DialogContext

  attr_accessor :user, :user_intents, :new_day, :current_node,
                :last_message, :buffered_nodes, :wit_response

  # ActiveRecord Model instances
  attr_accessor :conversation, :message

  def initialize(user)
    @user = user
    @buffered_nodes = []
  end

  def reset!
    @current_node = DialogNode.get_node(:start).new(self)
    @conversation = Conversation.create(user: @user, start: DateTime.now)
  end

  def timed_out?
    @conversation.timed_out?
  end

  # Get all current intents above threshold
  def user_intents
    @wit_response.valid_intents
  end


  ######################################
  ## Convenience methods              ##
  ######################################

  def yes?
    @wit_response.intent_with_value?(:yes_no, 'yes')
  end

  def no?
    @wit_response.intent_with_value?(:yes_no, 'no')
  end
end