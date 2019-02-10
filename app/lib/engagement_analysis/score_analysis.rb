module EngagementAnalysis
  class ScoreAnalysis < Base

    def call(data_in, metrics, engagement)

      engagement[:score] = score_logic(metrics)

      successor.call(data_in, metrics, engagement)
    end

    private

    def score_logic(metrics)
      score = 0

      # TODO: This is VERY basic. Needs to be more sophisticated!
      score += metrics[:message][:length] * MESSAGE_LENGTH
      score += metrics[:message][:sentiment] * SENTIMENT_WEIGHT
      score += metrics[:activity][:first_today] * ACTIVE_DAY
      score += metrics[:activity][:new_conversation] * NEW_CONVERSATION
      score += metrics[:goal] * GOAL_ACHIEVEMENT_WEIGHT

      score
    end
  end
end