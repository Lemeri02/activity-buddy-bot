class DialogNode::Joke < DialogNode

  INPUT_CONTEXT   = []
  OUTPUT_CONTEXT  = []
  INTENTS         = [:joke]

  WAIT_FOR_USER = true

  def message
    message_for_strategy
  end
end