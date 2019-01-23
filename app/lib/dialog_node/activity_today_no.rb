class DialogNode::ActivityTodayNo < DialogNode

  INPUT_CONTEXT = [:confirm_activity_today]
  OUTPUT_CONTEXT = []
  
  WAIT_FOR_USER = false

  PRIORITY = 10

  def self.applicable?(context)
    return false unless super
    return false unless context.no?
    true
  end

  def message
    "Too bad! But there is still time..."
  end
end