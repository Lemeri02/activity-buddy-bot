module EngagementAnalysis
  class InitAnalysis < Base

    def call(data_in)

      metrics = {}
      engagement = {}

      engagement[:user_id]          = data_in[:user_id]
      engagement[:message_id]       = data_in[:message_id]
      engagement[:conversation_id]  = data_in[:conversation_id]
      engagement[:strategy]         = data_in[:strategy]

      successor.call(data_in, metrics, engagement)
    end
  end
end