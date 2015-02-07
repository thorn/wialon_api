# encoding: utf-8
module WialonApi
  class Error < StandardError
    attr_reader :error_code
    attr_reader :error_messages
    attr_reader :message

    def initialize(data)
      @error_code = data.error
      @message = "Wialon server #{WialonApi.wialon_host} returned error #{error_code}: #{error_descriptions[@error_code.to_s]}"
    end

    def error_descriptions
      {
        '0' => 'Successful operation (for example for logout it will be success exit)',
        '1' => 'Invalid session',
        '2' => 'Invalid service name',
        '3' => 'Invalid result',
        '4' => 'Invalid input',
        '5' => 'Error performing request',
        '6' => 'Unknown error',
        '7' => 'Access denied',
        '8' => 'Invalid user name or password',
        '9' => 'Authorization server is unavailable',
        '10' => 'Reached limit of concurrent requests',
        '1001' => 'No messages for selected interval',
        '1002' => 'Item with such unique property already exists or Item cannot be created according to billing restrictions',
        '1003' => 'Only one request is allowed at the moment',
        '2014' => 'Selected user is a creator for some system objects, thus this user cannot be bound to a new account'
      }
    end
  end
end



