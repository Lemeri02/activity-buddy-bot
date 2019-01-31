class DialogNode::AskActivityToday < DialogNode

  INPUT_CONTEXT = []
  OUTPUT_CONTEXT = [:confirm_activity_today]

  WAIT_FOR_USER = true


  def message
    message_for_strategy
  end
end