class DialogNode::Start < DialogNode

  INPUT_CONTEXT = []
  OUTPUT_CONTEXT = []

  WAIT_FOR_USER = false

  PRIORITY = -1

  def self.applicable?(context)
    return false unless super
    return false unless context.buffered_nodes.empty?
    true
  end

  def message
    ""
  end
end