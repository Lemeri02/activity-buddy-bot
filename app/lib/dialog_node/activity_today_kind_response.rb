class DialogNode::ActivityTodayKindResponse < DialogNode

  INPUT_CONTEXT = [:response_activity_type]
  OUTPUT_CONTEXT = []

  INTENTS = [:activity]

  PRIORITY = 10
  
  WAIT_FOR_USER = true

  def self.applicable?(context)
    return false unless super
    true
  end

  def message
    # Get date of reported activity, set to today if no datetime entity
    date_entity = @context.wit_response.intent_value(:datetime)
    date = date_entity ? Date.parse(date_entity) : Date.today

    # Create activity
    Activity.create(user: @context.user, date: date, activity_type: @context.wit_response.intent_value(:activity))

    # Return message
    message_for_strategy
  end
end