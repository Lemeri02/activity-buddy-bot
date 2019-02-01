module EngagementAnalysis
  class UserEngagement

    MIN_CONVERSATIONS_PER_STRATEGY = 3

    class << self

      def engagement_for_user(user_id)
        engagement_per_conversation = Engagement.with_user(user_id).to_a.group_by(&:conversation_id)

        final_score = 0
        days_since_last_conversations = 0.0
        last_conversation_date = nil
        engagement_per_conversation.each do |_conv_id, engagements|
          score = engagements.sum(&:score)
          days_since_last_conversations = (engagements.first.created_at.to_datetime - last_conversation_date).to_f if last_conversation_date
          last_conversation_date = engagements.first.created_at.to_datetime

          decay_coeff = (1 - [days_since_last_conversations, 30.0].min / 30.0)
          final_score = (final_score * decay_coeff + score).round
        end
        final_score
      end

      def average_engagement_per_strategy_for_user(user_id)
        strategies = Engagement.with_user(user_id).pluck(:strategy).uniq

        average_engagement = {}
        strategies.each do |strategy|
          average_engagement[strategy] = Engagement.with_user(user_id).with_strategy(strategy).order(:conversation_id).average(:score).to_f
        end

        average_engagement.with_indifferent_access
      end

      def last_strategy_for_user(user_id)
        Engagement.with_user(user_id).order(created_at: :desc).first&.strategy&.to_sym
      end

      def engagement_changes_per_conversation_for_user(user_id)
        engagement_per_conversation = Engagement.with_user(user_id).group(:conversation_id).sum(:score).to_a
        return {} if engagement_per_conversation.empty?
        changes = {}
        engagement_per_conversation[1..-1].each_with_index do |(k, v), i|
          prev = engagement_per_conversation[i].second.to_f
          changes[k] = (((v - prev).to_f / prev.abs) * 100.0).round
        end
        changes
      end

      def change_strategy_for_user?(user_id)
        changes = engagement_changes_per_conversation_for_user(user_id).to_a.last(MIN_CONVERSATIONS_PER_STRATEGY).collect(&:second)

        # Do not change strategy if there are less than 3 conversations
        return false if changes.size < MIN_CONVERSATIONS_PER_STRATEGY
        # Do not change strategy for at least 3 conversations
        return false if Engagement.with_user(user_id).by_date.limit(MIN_CONVERSATIONS_PER_STRATEGY).pluck(:strategy).uniq.size > 1
        # Change strategy if average of change in engagement (percent) over last 3 conversations is negative
        (changes.reduce(0.0, :+) / changes.size) <= 0.0
      end
    end
  end
end