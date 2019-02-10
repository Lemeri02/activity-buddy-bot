module EngagementAnalysis
  class ActivityAnalysis < Base

    def call(data_in, metrics, engagement)
      metrics[:activity] ||= {}

      metrics[:activity][:first_today] = is_first_message_today?(data_in[:user_id])
      metrics[:activity][:new_conversation] = is_new_conversation?(data_in[:user_id], data_in[:conversation_id])

      successor.call(data_in, metrics, engagement)
    end

    private

    def is_first_message_today?(user_id)
      Engagement.with_user(user_id).today.any? ? 1 : 0
    end

    def is_new_conversation?(user_id, conversation_id)
      Engagement.with_user(user_id).where(conversation_id: conversation_id).any? ? 0 : 1
    end
  end
end