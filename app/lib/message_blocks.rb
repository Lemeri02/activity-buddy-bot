module MessageBlocks
  MESSAGES = {
    fallback: {
      # Fallback blocks
      welcome:              ["Hi <%= @context.user.firstname%>", "Welcome <%= @context.user.firstname %>"],
      start:                [""],
      ask_activity_today:   ["Did you do some activity today?", "Have you already been doing something for your health today?"],
      activity_today_no:    ["Too bad! But there is still time...", "Hmm, that's not good. You should really do something!"],
      activity_today_yes:   ["Great! I like to hear that!"],
      end:                  ['']
    },
    supportive: {
      # Message blocks for strategy supportive
      #welcome:             :fallback
      #start:               :fallback
      ask_activity_today:   ["I hope you have good news for me. Did you already do some activity?"],
      activity_today_no:    ["Well, I'm sure you have a busy schedule, but you should do a bit more.", "Too bad! Regular excercise is really important for your health."],
      activity_today_yes:   ["Nice! I like to hear that, you are great!"]
    },
    disciplined: {
      # Message blocks for strategy disciplined
      welcome:              ["Hello <%= @context.user.firstname%>", "Welcome <%= @context.user.firstname%>"],
      start:                [""],
      ask_activity_today:   ["Do you have something to report?", "Tell me you already exercised today?!"],
      activity_today_no:    ["Whaaat? You are a lazy idiot!", "Don't you care about your health or are you just lazy? This is unacceptable!"],
      activity_today_yes:   ["Good! It was about time you do something for your health!"]
    }
  }

  def message_for_strategy(strategy = nil, node = nil)
    strategy ||= @context.strategy
    node ||= self.to_sym
    possible_responses = MESSAGES.dig(strategy, node) || MESSAGES.dig(:fallback, node) || "Message not defined: #{strategy} -> #{node}"
    response =  case possible_responses
                when String
                  possible_responses
                when Array
                  possible_responses.sample
                end
    return ERB.new(response).result(binding)
  end
end