require 'spec_helper'

describe WialonApi::Error do
  let(:error_data) { Hashie::Mash.new('error' => 4) }
  let(:error) { WialonApi::Error.new(error_data) }

  it '#message returns error message by it\'s code' do
    message = 'Неверный ввод'
    expect { fail error }.to raise_error(error.class, message)
  end
end