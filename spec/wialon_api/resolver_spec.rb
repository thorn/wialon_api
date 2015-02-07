require 'spec_helper'

describe WialonApi::Resolver do
  before(:each) do
    @class = Class.new do
      include WialonApi::Resolver

      attr_accessor :sid

      def initialize(name)
        @name = name
      end
    end
  end

  describe '#send' do
    before(:each) do
      @resolver = @class.new('trololo')
      @sid = double('sid')
      allow(@resolver).to receive(:sid).and_return(@sid)
    end

    it 'gets into #method_missing' do
      expect(@resolver).to receive(:method_missing).with(:send, message: 'hello')
      @resolver.send(message: 'hello')
    end
  end

  describe '#resolver' do
    before(:each) do
      @name     = double('Name')
      @resolver = @class.new(@name)
      @sid    = double('sid')
      allow(@resolver).to receive(:sid).and_return(@sid)
    end

    let(:resolver) { @resolver.resolver }

    it 'returns a Hashie::Mash with a name and a sid' do
      expect(resolver.name).to eq(@name)
      expect(resolver.sid).to eq(@sid)
    end

    it 'caches the result' do
      @mash = double('Mash', name: @name, sid: @sid)
      expect(Hashie::Mash).to receive(:new).once.and_return(@mash)
      5.times { @resolver.resolver }
    end
  end
end
