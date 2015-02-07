# encoding: utf-8
require 'spec_helper'

describe WialonApi::Error do
  let(:error_data) { Hashie::Mash.new('error' => 4) }
  let(:error) { WialonApi::Error.new(error_data) }

  it '#message returns error message by it\'s code' do
    message = "Wialon server #{WialonApi.wialon_host} returned error 4: Invalid input"
    expect { fail error }.to raise_error(error.class, message)
  end
end
