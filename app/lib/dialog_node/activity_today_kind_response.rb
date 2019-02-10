class DialogNode::ActivityTodayKindResponse < DialogNode

  INPUT_CONTEXT = [:response_activity_type]
  OUTPUT_CONTEXT = []

  INTENTS = [:activity]
  
  WAIT_FOR_USER = true

  def self.applicable?(context)
    return false unless super
    true
  end

  def message
    message_for_strategy
  end
end