class DialogNode::ActivityTodayYes < DialogNode

  INPUT_CONTEXT = [:confirm_activity_today]
  OUTPUT_CONTEXT = []
  
  WAIT_FOR_USER = false

  PRIORITY = 10


  def self.applicable?(context)
    return false unless super
    return false unless context.yes?
    true
  end

  def message
    "Very nice! You achieved something today!"
  end
end