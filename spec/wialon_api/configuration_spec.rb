require 'spec_helper'

# Dummy class
class TestConfiguration
  extend WialonApi::Configuration
end

describe WialonApi::Configuration do
  describe '#configure' do
    it 'yields self' do
      expect(TestConfiguration).to receive(:wialon_host)
      TestConfiguration.configure(&:wialon_host)
    end

    it 'returns self' do
      expect(TestConfiguration.configure).to eq(TestConfiguration)
    end
  end

  describe '#reset' do
    it 'resets all the values to their default values' do
      TestConfiguration.reset
      expect(TestConfiguration.wialon_host).to eq('https://hst-api.wialon.com/wialon/ajax.html')
      expect(TestConfiguration.wialon_edition).to eq(:hosting)
      expect(TestConfiguration.http_verb).to eq(:post)
      expect(TestConfiguration.max_retries).to eq(1)
      expect(TestConfiguration.faraday_options).to eq({})
      expect(TestConfiguration.faraday_options).to eq({})
      expect(TestConfiguration.adapter).to eq(Faraday.default_adapter)
      expect(TestConfiguration.logger).to be_a(Logger)
      expect(TestConfiguration.log_requests?).to eq(true)
      expect(TestConfiguration.log_errors).to eq(true)
      expect(TestConfiguration.log_responses).not_to eq(true)
    end
  end
end
