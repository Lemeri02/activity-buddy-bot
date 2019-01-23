class DialogNode::Welcome < DialogNode

  INPUT_CONTEXT   = []
  OUTPUT_CONTEXT  = []
  INTENTS         = [:welcome]

  WAIT_FOR_USER = false

  def message
    "Hi #{@context.user.firstname}"
  end
end