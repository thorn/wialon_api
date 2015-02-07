module WialonApi
  module Authorization
    def authorize(options)
      user = options.fetch(:user)
      password = options.fetch(:password)
      response = WialonApi::Api.call('core/login', user: user, password: password)
      result = WialonApi::Result.process(response)
      WialonApi::Client.new(result.eid)
    end
  end
end
