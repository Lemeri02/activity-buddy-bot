class WitResponse

  INTENT_MAPPING = { greetings: :welcome }.freeze
  CONFIDENCE_THRESHOLD = 0.8

  attr_reader :text, :intents

  def initialize(response)
    @text = response['_text']
    @intents = extract_intents(response)
  end

  def valid_intents
    @intents.select{ |_k, i| i[:confidence] >= CONFIDENCE_THRESHOLD }.map{ |i| i.first }
  end

  # Check for detected intent in WitResponse
  def intent?(intent)
    intent = intent.to_sym if intent.is_a?(String)
    return false unless @intents.key? intent
    return true if @intents[intent][:confidence] >= CONFIDENCE_THRESHOLD
    false
  end

  def intent_with_value?(intent, value)
    intent = intent.to_sym if intent.is_a?(String)

    # Check without value first
    return false unless intent?(intent)

    # Check value second
    v = intent_value(intent)
    v ? v == value : false
  end

  def to_s
    "<text: #{@text}, intents: #{@intents.inspect}>"
  end


  private

  def intent_value(intent)
    @intents.dig(intent, :value)
  end

  def extract_intents(wit_response)
    intents = {}
    wit_response["entities"].each do |entity, values|
      if entity == 'intent'
        values.each do |intent|
          intents[lookup_intent_mapping(intent['value'])] = { confidence: intent['confidence'] }
        end
      else
        intents[lookup_intent_mapping(entity)] = { confidence: values.first['confidence'], value: values.first['value'] }
      end
    end
    return intents
  end

  def lookup_intent_mapping(intent)
    intent = intent.to_sym if intent.is_a?(String)
    mapping = INTENT_MAPPING[intent]
    mapping ? mapping : intent
  end

end