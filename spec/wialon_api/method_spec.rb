require 'spec_helper'

describe WialonApi::Method do
  describe '#call' do
    let(:full_name) { double('Full method name') }
    let(:args) { double('Method arguments') }
    let(:sid) { double('Session\'s id') }

    let(:method) do
      WialonApi::Method.new('some_name').tap do |method|
        allow(method).to receive(:full_name).and_return(full_name)
        allow(method).to receive(:sid).and_return(sid)
      end
    end

    before(:each) do
      allow(WialonApi::Result).to receive(:process)
    end

    it 'calls API.call with full name, args and sid' do
      expect(WialonApi::Api).to receive(:call).with(full_name, args, sid)
      method.call(args)
    end

    it 'sends the response to Result.process' do
      response = double('WialonApi response')
      allow(WialonApi::Api).to receive(:call).and_return(response)

      expect(WialonApi::Result).to receive(:process).with(response, nil)
      method.call(args)
    end
  end

  describe '#full_name' do
    let(:method) do
      resolver = Hashie::Mash.new(name: 'name_space')
      WialonApi::Method.new('name', resolver: resolver)
    end

    it 'sends each part to #camelize' do
      expect(method.send(:full_name)).to eq('name_space/name')
    end
  end
end
