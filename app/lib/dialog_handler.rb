class DialogHandler

  def initialize(user)
    @user = user
    @context = DialogContext.new(@user)
    @context.reset!
  end

  def handle_message(message)
    # Restart conversation if timed out
    @context.reset! if @context.timed_out?

    # Send to Wit.ai
    resp = WitResponse.new WitProxy.message(message['text'])
    @context.last_message = message
    Rails.logger.debug("Message: #{message}")
    @context.wit_response = resp
    Rails.logger.debug("Extracted intents: #{resp}")

    # Create message and link to conversations
    @context.message = @context.conversation.add_message_from_wit_response(resp)

    # Proceed to next dialog node
    next_node!
    answer = @context.current_node.message

    # Proceed to next dialog node unless a user message is expected
    while(!@context.current_node.wait_for_user?) do
      next_node!
      answer << "\n" + @context.current_node.message
    end

    # Analyze User Engagement, can be done in background task
    @context.send_to_engagement_analysis

    # Reset buffered node and return answer
    @context.buffered_nodes   = []
    @context.goal_achievement = 0
    @context.message.update_attribute(:answer, answer)
    return answer
  end

  def next_node!
    @context.buffered_nodes << @context.current_node.to_sym
    # Select intent
    # TODO: Sophisticated algorithm to select out of multiple next nodes
    Rails.logger.debug("Applicable nodes: #{applicable_nodes}")
    Rails.logger.debug("Buffered nodes: #{@context.buffered_nodes}")
    possible_nodes = (applicable_nodes - @context.buffered_nodes)
    Rails.logger.debug("Possible next nodes: #{possible_nodes}")
    next_node = possible_nodes.map{ |n| DialogNode.get_node(n).new(@context) }.max_by(&:priority)
    @context.current_node = next_node
    Rails.logger.debug("==> Switch to node <#{next_node}>")
  end

  private

  def applicable_nodes
    DialogNode.applicable_nodes(@context)
  end

end