module WialonApi
  module Authorization
    def authorize(user, password)
      response = WialonApi::Api.call('core/login', user: user, password: password)
      result = WialonApi::Result.process(response)
      WialonApi::Client.new(result.send(WialonApi.wialon_client_session_identifier))
    end
  end
end
