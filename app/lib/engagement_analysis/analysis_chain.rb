module EngagementAnalysis
  class AnalysisChain
    class << self

      def run(*args)
        initialized_handlers.first.call(*args)
      end

      protected

      def handlers
        [
          EngagementAnalysis::InitAnalysis,
          EngagementAnalysis::MessageAnalysis,
          EngagementAnalysis::ActivityAnalysis,
          EngagementAnalysis::GoalAnalysis,
          EngagementAnalysis::ScoreAnalysis,
          EngagementAnalysis::SaveAnalysis
        ]
      end


      def initialized_handlers
        return @initialized_handlers if defined? @initialized_handlers
        @initialized_handlers = handlers.map(&:new)
        @initialized_handlers[0...-1].each_with_index { |handler, i| handler.successor = @initialized_handlers[i + 1] }
        @initialized_handlers
      end
    end
  end
end