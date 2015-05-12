require 'spec_helper'

describe WialonApi::Logger do
  before(:each) do
    WialonApi.logger = double('Logger').as_null_object

    WialonApi.log_requests  = false
    WialonApi.log_responses = false
    WialonApi.log_errors    = false
  end

  let(:success_response) { Oj.dump('a' => 1, 'b' => 2) }
  let(:success_array_response) { Oj.dump(['a' => 1, 'b' => 2])}
  let(:fail_response) { Oj.dump('error' => 404) }

  let(:connection) do
    Faraday.new(url: 'http://example.com') do |builder|
      builder.request :url_encoded
      builder.response :wialon_logger
      builder.response :mashify
      builder.response :oj, preserve_raw: true

      builder.adapter :test do |stub|
        stub.get('/success') do
          [200, {}, success_response]
        end

        stub.post('/success') do
          [200, {}, success_response]
        end

        stub.get('/array_success') do
          [200, {}, success_array_response]
        end

        stub.get('/fail') do
          [200, {}, fail_response]
        end
      end
    end
  end

  context 'with WialonApi.log_requests?' do
    before(:each) do
      WialonApi.log_requests = true
    end

    it 'logs the request URL' do
      expect(WialonApi.logger).to receive(:debug).with('GET http://example.com/success')
      connection.get('/success')
    end

    it 'logs the request URL with array response' do
      expect(WialonApi.logger).to receive(:debug).with('GET http://example.com/array_success')
      connection.get('/array_success')
    end

    context 'with a POST request' do
      it 'logs the request URL and the request body' do
        expect(WialonApi.logger).to receive(:debug).with('POST http://example.com/success')
        expect(WialonApi.logger).to receive(:debug).with('body: "param=1"')
        connection.post('/success', param: 1)
      end
    end
  end

  context 'without WialonApi.log_requests?' do
    it 'does not log the request' do
      expect(WialonApi.logger).not_to receive(:debug)
      connection.get('/success')
    end
  end

  context 'with a successful response' do
    context 'with WialonApi.log_responses?' do
      before(:each) do
        WialonApi.log_responses = true
      end

      it 'logs the response body' do
        expect(WialonApi.logger).to receive(:debug).with(success_response)
        connection.get('/success')
      end
    end

    context 'without WialonApi.log_responses?' do
      it 'does not log the response body' do
        expect(WialonApi.logger).not_to receive(:debug)
        connection.get('/success')
      end
    end
  end

  context 'with an error response' do
    context 'with WialonApi.log_errors?' do
      before(:each) do
        WialonApi.log_errors = true
      end

      it 'logs the response body' do
        expect(WialonApi.logger).to receive(:warn).with(fail_response)
        connection.get('/fail')
      end
    end

    context 'without WialonApi.log_errors?' do
      it 'does not log the response body' do
        expect(WialonApi.logger).not_to receive(:warn)
        connection.get('/fail')
      end
    end
  end
end
