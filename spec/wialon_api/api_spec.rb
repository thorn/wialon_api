require 'spec_helper'

describe WialonApi::Api do
  def create_connection
    @result = { 'response' => { 'key' => 'value' } }

    @connection = Faraday.new do |builder|
      builder.response :mashify
      builder.response :oj, preserve_raw: true
      builder.adapter :test do |stub|
        stub.post('/') do
          [200, {}, Oj.dump(@result)]
        end
      end
    end
    allow(subject).to receive(:connection).and_return(@connection)
  end

  describe '.call' do
    before(:each) do
      WialonApi.reset
      create_connection
    end

    it 'sends a sid if it was passed with parameter' do
      expect(subject).to receive(:connection).with(url: WialonApi.wialon_host)
      subject.call('core/search_items', { params: :value }, 'sid')
    end
  end

  describe '.connection' do
    it 'uses the :url parameter and WialonApi.faraday_options' do
      faraday_options = double('Faraday options')
      allow(WialonApi).to receive(:faraday_options).and_return(faraday_options)
      url = double('URL')

      expect(Faraday).to receive(:new).with(url, faraday_options)
      subject.connection(url: url)
    end
  end
end
