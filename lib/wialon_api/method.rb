module WialonApi
  # An API method. It is responsible for generating it's full name and determining it's type.
  class Method
    include Resolvable

    # A pattern for names of methods with a boolean result.
    PREDICATE_NAMES = /^is.*\?$/

    # Calling the API method.
    # It delegates the network request to `API.call` and result processing to `Result.process`.
    # @param [Hash] args Arguments for the API method.
    def call(args = {}, &block)
      response = Api.call(full_name, args, sid)
      Result.process(response, block)
    end

    private

    def full_name
      [@previous_resolver.name, @name].join('/')
    end
  end
end
