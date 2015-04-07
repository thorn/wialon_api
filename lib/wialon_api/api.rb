require 'json'

module WialonApi
  module Api
    def self.call(service_name, args = {}, sid = nil)
      parameters = { svc: service_name, params: args.to_json, WialonApi.wialon_session_identifier => sid }
      connection(url: WialonApi.wialon_host).send(WialonApi.http_verb, nil, parameters).body
    end

    def self.connection(options = {})
      url = options.delete(:url)
      Faraday.new(url, WialonApi.faraday_options) do |builder|
        builder.request :url_encoded
        builder.request :retry, WialonApi.max_retries

        builder.response :wialon_logger
        builder.response :mashify
        builder.response :oj, preserve_raw: true

        builder.adapter WialonApi.adapter
      end
    end
  end
end
