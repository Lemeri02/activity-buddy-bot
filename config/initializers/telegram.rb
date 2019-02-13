# Initialize the telegram bot
Telegram.bots_config = {
  default: ENV["TELEGRAM_API_KEY"] || Rails.application.credentials[Rails.env.to_sym][:telegram][:bot]
}