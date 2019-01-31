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
      score += metrics[:message][:length]
      score += metrics[:message][:sentiment] * SENTIMENT_WEIGHT
      score += metrics[:goal] * GOAL_ACHIEVEMENT_WEIGHT

      score
    end
  end
end