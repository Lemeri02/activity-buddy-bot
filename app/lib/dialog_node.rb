class DialogNode
  include MessageBlocks

  # Define default values
  INPUT_CONTEXT   = []
  OUTPUT_CONTEXT  = []
  INTENTS         = []
  PRIORITY        = 0


  ALL_NODES = [
      :start, :end, :welcome, :joke, :ask_activity_today, :activity_today_yes, :activity_today_no, :activity_today_kind,
      :activity_today_kind_response, :activity_today_yes_with_kind
    ].map{ |t| [t, "DialogNode/#{t}".camelize.constantize] }.to_h


  class << self
    def get_node(name)
      ALL_NODES[name]
    end

    def all_nodes
      ALL_NODES.values
    end

    def applicable_nodes(context)
      ALL_NODES.select{ |_k, n| n.applicable?(context) }.collect(&:first)
    end

    def applicable?(context)
      return false unless context_match?(context)
      return false unless intents_match?(context)
      true
    end

    def context_match?(context, allow_empty = true)
      return false if !allow_empty && self::INPUT_CONTEXT.empty?
      self::INPUT_CONTEXT.empty? || (self::INPUT_CONTEXT && context.current_node.output_context).any?
    end

    def intents_match?(context, allow_empty = true)
      return false if !allow_empty && self::INTENTS.empty?
      self::INTENTS.empty? || (self::INTENTS & context.user_intents).any?
    end

    def order_by_priority(nodes, context)
      nodes.sort_by { |n| n.priority }.reverse!
    end

    def to_sym
      self.to_s.underscore.split('/').last.to_sym.freeze
    end
  end

  def initialize(context)
    @context = context
  end

  def priority

    return @priority if defined? @priority
    @priority = self.class::PRIORITY
    @priority += 10 if intents_match?(false)
    @priority += 10 if context_match?(false)
    Rails.logger.debug("Piority #{self.class}: #{@priority}")
    @priority
  end

  def context_match?(allow_empty = true)
    self.class.context_match? @context, allow_empty
  end

  def intents_match?(allow_empty = true)
    self.class.intents_match? @context, allow_empty
  end

  def wait_for_user?
    self.class::WAIT_FOR_USER
  end

  def input_context
    self.class::INPUT_CONTEXT
  end

  def output_context
    self.class::OUTPUT_CONTEXT + @context.dynamic_output_context
  end

  def intents
    self.class::INTENTS
  end

  def to_sym
    self.class.to_sym
  end
end