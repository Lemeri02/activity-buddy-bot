class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session

  def start!(*)
    respond_with :message, text: t('.hi')
  end

  def message(message)
    # Receive message

    # Handle message

    # Determine context/answer

    respond_with :message, text: "Hi #{user.firstname}!"
  end

  private

  def user
    @user ||= User.find_by_telegram_id(from['id']) || User.create_from_message!(from)
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end