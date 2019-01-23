class DialogNode::NewDay < DialogNode

  WAIT_FOR_USER = false

  def self.applicable?(context)
    return false unless super
    return false unless context.new_day
    true
  end

  def message
    "Hi #{@context.user.firstname}"
  end
end