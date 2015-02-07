require 'spec_helper'

describe WialonApi::Resolvable do
  before(:each) do
    @class = Class.new do
      include WialonApi::Resolvable
    end
  end

  describe '#initialize' do
    it 'saves the name and the resolver' do
      resolver   = Hashie::Mash.new(sid: 'sid')
      resolvable = @class.new(:name, resolver: resolver)

      expect(resolvable.name).to eq('name')
      expect(resolvable.sid).to eq('sid')
    end
  end
end
