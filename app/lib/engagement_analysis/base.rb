module EngagementAnalysis
  class Base
    attr_accessor :successor

    # Constants for weighting different aspects of User Engagement Score
    MESSAGE_LENGTH          = 1
    ACTIVE_DAY              = 5
    NEW_CONVERSATION       = 5
    SENTIMENT_WEIGHT        = 10
    GOAL_ACHIEVEMENT_WEIGHT = 20

    def initialize(successor = nil)
      @successor = successor
    end

    def call
      raise NotImplementedError
    end
  end
end