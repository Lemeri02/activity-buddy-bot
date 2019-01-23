class DialogNode::AskActivityToday < DialogNode

  INPUT_CONTEXT = []
  OUTPUT_CONTEXT = [:confirm_activity_today]

  WAIT_FOR_USER = true


  def message
    "Did you do some activity today?"
  end
end