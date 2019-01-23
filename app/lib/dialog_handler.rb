class DialogHandler

  def initialize(user)
    @user = user
    @context = DialogContext.new(@user)
    @context.current_node = DialogNode.get_node(:start).new(@context)
  end

  def handle_message(message)
    # @messages << { time: DateTime.now, text: message}

    # Send to Wit.ai
    resp = WitProxy.message(message['text'])
    @context.last_message = resp
    Rails.logger.debug("Received from Wit.ai: #{resp}")
    @context.last_user_intents = extract_intents(resp)
    Rails.logger.debug("Extracted intents: #{@context.user_intents}")

    next_node!
    answer = @context.current_node.message

    while(!@context.current_node.wait_for_user?) do
      next_node!
      answer << "\n" + @context.current_node.message
    end

    @context.buffered_nodes = []
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

  def extract_intents(wit_response)
    intents = []
    wit_response["entities"].each do |entity, values|
      if 'intent' == entity
        intents << values.select{ |v| v['confidence'] >= 0.8 }.collect{ |v| v['value'].to_sym }
      elsif ['greetings'].include? entity
        intents << :welcome if values.first['confidence'] >= 0.8
      end
    end
    intents.flatten.uniq
  end

end