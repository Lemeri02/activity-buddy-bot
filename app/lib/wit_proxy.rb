class WitProxy

  ACCESS_TOKEN = Rails.application.credentials[Rails.env.to_sym][:wit][:token].freeze

  @client = Wit.new(access_token: ACCESS_TOKEN)

  class << self
    attr_reader :client

    def message(message)
      client.message(message)
    end
  end
end