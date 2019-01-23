Rails.application.routes.draw do

  # Telegram Bot Webhook
  telegram_webhook TelegramWebhooksController
end
