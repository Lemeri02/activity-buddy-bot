# Initialize the telegram bot
Telegram.bots_config = {
  default: Rails.application.credentials[Rails.env.to_sym][:telegram][:bot]
}