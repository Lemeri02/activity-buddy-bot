class DialogContext

  attr_accessor :user, :user_intents, :new_day, :current_node, :goal_achievement,
                :last_message, :buffered_nodes, :wit_response, :strategy,
                :dynamic_output_context

  # ActiveRecord Model instances
  attr_accessor :conversation, :message

  def initialize(user)
    @user = user
    @buffered_nodes = []
  end

  def reset!
    @current_node     = DialogNode.get_node(:start).new(self)
    @conversation     = Conversation.create(user: @user, start: DateTime.now)
    @strategy         = EngagementAnalysis::UserEngagement.strategy_for_user(@user.id, @current_node.available_strategies)
    @goal_achievement = 0
    @dynamic_output_context = []
  end

  def timed_out?
    @conversation.timed_out?
  end

  # Get all current intents above threshold
  def user_intents
    @wit_response.valid_intents
  end

  def send_to_engagement_analysis
    pp EngagementAnalysis::UserEngagement.analyze!(
      {
        user_id: @user.id,
        message_id: @message.id,
        conversation_id: @conversation.id,
        text: @last_message,
        strategy: @strategy,
        goal_achievement: @goal_achievement
      }
    )
  end


  ######################################
  ## Convenience methods              ##
  ######################################

  def yes?
    @wit_response.intent_with_value?(:yes_no, 'yes', 0.6)
  end

  def no?
    @wit_response.intent_with_value?(:yes_no, 'no', 0.6)
  end

  def has_intent?(intent)
    @wit_response.valid_intents.include? intent
  end

  def intent_has_value?(intent)
    @wit_response.intent_has_value?(intent)
  end
end