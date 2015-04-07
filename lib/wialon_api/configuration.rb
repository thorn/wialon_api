require 'logger'

module WialonApi
  module Configuration
    OPTION_NAMES = [
      :wialon_host,
      :wialon_edition,
      :http_verb,
      :max_retries,
      :faraday_options,
      :adapter,
      :logger,
      :log_requests,
      :log_errors,
      :log_responses
    ]

    attr_accessor(*OPTION_NAMES)

    READ_ONLY_OPTIONS = [
      :wialon_session_identifier,
      :wialon_client_session_identifier
    ]

    attr_reader(*READ_ONLY_OPTIONS)

    alias_method :log_requests?,  :log_requests
    alias_method :log_errors?,    :log_errors
    alias_method :log_responses?, :log_responses

    DEFAULT_WIALON_HOST = 'https://hst-api.wialon.com/wialon/ajax.html'
    DEFAULT_WIALON_EDITION = :hosting
    DEFAULT_SESSION_IDENTIFIER = :sid
    DEFAULT_CLIENT_SESSION_IDENTIFIER = :eid
    DEFAULT_HTTP_VERB = :post
    DEFAULT_MAX_RETRIES = 1
    DEFAULT_ADAPTER = Faraday.default_adapter
    DEFAULT_LOGGER_OPTIONS = {
      requests:  true,
      errors:    true,
      responses: false
    }

    def configure
      yield self if block_given?
      self
    end

    def reset
      @wialon_host = DEFAULT_WIALON_HOST
      @wialon_edition = DEFAULT_WIALON_EDITION
      @wialon_session_identifier = DEFAULT_SESSION_IDENTIFIER
      @wialon_client_session_identifier = DEFAULT_CLIENT_SESSION_IDENTIFIER
      @http_verb   = DEFAULT_HTTP_VERB
      @max_retries = DEFAULT_MAX_RETRIES
      @faraday_options = {}
      @adapter         = DEFAULT_ADAPTER
      @logger          = ::Logger.new(STDOUT)
      @log_requests    = DEFAULT_LOGGER_OPTIONS[:requests]
      @log_errors      = DEFAULT_LOGGER_OPTIONS[:errors]
      @log_responses   = DEFAULT_LOGGER_OPTIONS[:responses]
    end

    def self.extended(base)
      base.reset
    end

    def wialon_edition=(edition)
      @wialon_edition = edition
      if edition == :pro
        @wialon_session_identifier = :ssid
        @wialon_client_session_identifier = :ssid
      end
    end
  end
end
