require 'json'

module WialonApi
  module Api
    def self.call(service_name, args = {}, sid = nil)
      parameters = { svc: service_name, params: args.to_json, sid: sid }
      connection(url: WialonApi.wialon_host, sid: sid).send(WialonApi.http_verb, WialonApi.wialon_host, parameters).body
    end

    def self.connection(options = {})
      url = options.delete(:url)
      Faraday.new(url, WialonApi.faraday_options) do |builder|
        builder.request :url_encoded
        builder.request :retry, Wialon.max_retries

        builder.response :wialon_logger
        builder.response :mashify
        builder.response :oj, preserve_raw: true

        builder.adapter Wialon.adapter
      end
    end
  end
end
