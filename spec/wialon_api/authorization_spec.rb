require 'spec_helper'

describe WialonApi::Authorization do
  describe '.authorize' do
    let(:success) { Hashie::Mash.new(eid: 'sid') }
    let(:error) { Hashie::Mash.new(error: '8') }
    let(:credentials) { ['user', 'password'] }

    it 'bulds a WialonApi client if the credentials are correct' do
      allow(WialonApi::Api).to receive(:call).and_return(success)
      expect(WialonApi::Client).to receive(:new).with('sid', success)
      WialonApi.authorize(*credentials)
    end

    it 'raises an error if password or login do not match' do
      allow(WialonApi::Api).to receive(:call).and_return(error)
      expect { WialonApi.authorize(*credentials) }.to raise_error(WialonApi::Error)
    end
  end
end
