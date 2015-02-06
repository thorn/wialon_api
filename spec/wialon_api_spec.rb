require 'spec_helper'

describe WialonApi do
  it 'should return current version' do
    expect(WialonApi::VERSION).to eq('0.0.1')
  end
end
