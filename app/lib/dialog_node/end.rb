class DialogNode::End < DialogNode

  INPUT_CONTEXT   = []
  OUTPUT_CONTEXT  = []

  WAIT_FOR_USER = true

  PRIORITY = -1

  def message
    message_for_strategy
  end
end