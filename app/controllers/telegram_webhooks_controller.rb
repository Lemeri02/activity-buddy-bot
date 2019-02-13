class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session

  def start!(*)
    respond_with :message, text: "Hi! I'm ActivityBuddy. I will help you being more active and stay in shape!"
  end

  def message(message)
    # Handover to DialogHandler
    answer = dialog_handler.handle_message(message)

    # Return response
    respond_with :message, text: answer
  end

  private

  def user
    @user ||= User.find_by_telegram_id(from['id']) || User.create_from_message!(from)
  end

  def dialog_handler
    return @dialog_handler if defined? @dialog_handler
    session[:dh] ||= DialogHandler.new(user)
    @dialog_handler = session[:dh]
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end