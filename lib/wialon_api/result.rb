module WialonApi
  class Result
    def self.process(response, block = nil)
      result = extract_result(response)
      if result.respond_to?(:each)
        block.nil? ? result : result.map(&block)
      else
        block.nil? ? result : block.call(result)
      end
    end

    def self.extract_result(response)
      if response.respond_to?(:error) && response.error
        fail WialonApi::Error.new(response)
      else
        response
      end
    end
  end
end
