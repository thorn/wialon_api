module WialonApi
  class Client
    include WialonApi::Resolver

    attr_reader :sid

    def initialize(sid = nil)
      @sid = sid
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
