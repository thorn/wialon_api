require 'spec_helper'

describe WialonApi::Client do
  let(:sid) { 'sid' }

  describe '#authorized?' do
    context 'with an unauthorized client' do
      let(:client) { WialonApi::Client.new }

      it 'returns false' do
        expect(client).not_to be_authorized
      end
    end

    context 'with an authorized client' do
      let(:client) { WialonApi::Client.new(sid) }

      it 'returns true' do
        expect(client).to be_authorized
      end
    end
  end
end
