class DialogContext

  attr_accessor :user, :user_intents, :new_day, :current_node, :goal_achievement,
                :last_message, :buffered_nodes, :wit_response, :strategy

  # ActiveRecord Model instances
  attr_accessor :conversation, :message

  def initialize(user)
    @user = user
    @buffered_nodes = []
  end

  def reset!
    @current_node     = DialogNode.get_node(:start).new(self)
    @conversation     = Conversation.create(user: @user, start: DateTime.now)
    last_strategy     = EngagementAnalysis::UserEngagement.last_strategy_for_user(@user.id)
    @strategy         = EngagementAnalysis::UserEngagement.change_strategy_for_user?(@user.id) ? (@current_node.available_strategies - [last_strategy]).sample : last_strategy
    @goal_achievement = 0
  end

  def timed_out?
    @conversation.timed_out?
  end

  # Get all current intents above threshold
  def user_intents
    @wit_response.valid_intents
  end

  def send_to_engagement_analysis
    pp EngagementAnalysis::AnalysisChain.run(
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
end