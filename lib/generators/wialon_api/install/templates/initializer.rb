WialonApi.configure do |config|
  # Faraday adapter to make requests with:
  # config.adapter = :net_http

  # Faraday connection options
  # config.faraday_options = {}

  # HTTP verb for API methods (:get or :post)
  # config.http_verb = :post

  # Number of retries when connection is failed
  # config.max_retries = 1


  # Logging parameters:
  # log everything through the rails logger
  config.logger = Rails.logger

  # log requests' URLs
  # config.log_requests = true

  # log response JSON after errors
  # config.log_errors = true

  # log response JSON after successful responses
  # config.log_responses = false

  # Wialon server host
  # config.wialon_host = 'https://hst-api.wialon.com/wialon/ajax.html'

  # Wialon server edition: :hosting, :local, :pro
  # config.wialon_edition = :hosting
end
