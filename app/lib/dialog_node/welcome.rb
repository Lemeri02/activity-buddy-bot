class DialogNode::Welcome < DialogNode

  INPUT_CONTEXT   = []
  OUTPUT_CONTEXT  = []
  INTENTS         = [:welcome]

  WAIT_FOR_USER = false

  def message
    message_for_strategy
  end
end