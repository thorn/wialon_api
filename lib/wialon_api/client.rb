module WialonApi
  class Client
    include WialonApi::Resolver

    attr_reader :sid, :info

    def initialize(sid = nil, info = {})
      @sid = sid
      @info = info
    end

    def authorized?
      !@sid.nil?
    end

    def execute(*args)
      call_method(*args)
    end

    # If the called method is a namespace, it creates and returns a new `WialonApi::Namespace` instance.
    # Otherwise it creates a `WialonApi::Method` instance and calls it passing the arguments and a block.
    def method_missing(*args, &block)
      if Namespace.exists?(args.first)
        create_namespace(args.first)
      else
        call_method(args, &block)
      end
    end
  end
end
