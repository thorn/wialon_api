module WialonApi
  module Authorization
    def authorize(user, password)
      response = WialonApi::Api.call('core/login', user: user, password: password)
      result = WialonApi::Result.process(response)
      if WialonApi.wialon_edition == :pro
        WialonApi::Client.new(result.ssid)
      else
        WialonApi::Client.new(result.eid)
      end
    end
  end
end
