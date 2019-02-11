class DialogNode::GiveFeedback < DialogNode

  INPUT_CONTEXT = []
  OUTPUT_CONTEXT = []

  INTENTS = [:feedback]

  WAIT_FOR_USER = true


  def message
    @no_activities = Activity.with_user(@context.user).last_n_days(7).count
    @feedback_positive = @no_activities > 3
    message_for_strategy
  end
end