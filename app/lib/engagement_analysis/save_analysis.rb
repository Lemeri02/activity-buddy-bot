module EngagementAnalysis
  class SaveAnalysis < Base

    def call(data_in, metrics, engagement)

      e = Engagement.new(engagement)
      e.metrics = metrics
      e.save!

      return e.to_h
    end
  end
end