module EngagementAnalysis
  class GoalAnalysis < Base

    def call(data_in, metrics, engagement)

      # TODO: How should this be handled?
      # - Per Message, Per conversation?
      # - Impact on this measure point? Or previous?
      # - Leave it to client?
      metrics[:goal] = data_in[:goal_achievement]

      successor.call(data_in, metrics, engagement)
    end
  end
end