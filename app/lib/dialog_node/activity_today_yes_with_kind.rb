class DialogNode::ActivityTodayYesWithKind < DialogNode

  INPUT_CONTEXT = [:confirm_activity_today]
  OUTPUT_CONTEXT = [:response_activity_type]

  INTENTS = [:activity]
  
  WAIT_FOR_USER = false

  PRIORITY = 10


  def self.applicable?(context)
    return false unless super
    # return false unless context.yes?
    true
  end

  def message
    @context.goal_achievement = 1
    message_for_strategy
  end
end