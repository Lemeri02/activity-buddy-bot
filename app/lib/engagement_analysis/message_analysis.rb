module EngagementAnalysis
  class MessageAnalysis < Base

    def call(data_in, metrics, engagement)
      metrics[:message] ||= {}

      metrics[:message][:length] = data_in[:text].size
      metrics[:message][:sentiment] = sentiment_mapping(data_in[:sentiment])

      successor.call(data_in, metrics, engagement)
    end

    private

    def sentiment_mapping(sentiment)
      return 0 if sentiment.nil?
      return -1 if sentiment.to_s == 'negative'
      return 1 if sentiment.to_s == 'positive'
      return 0
    end
  end
end