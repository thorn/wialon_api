require 'spec_helper'

describe WialonApi::Result do
  describe '.process' do
    let(:response) { double('Response') }
    let(:result) { double('Result') }

    before(:each) do
      allow(WialonApi::Result).to receive(:extract_result).and_return(result)
    end

    it 'calls .extract_result passing it the response' do
      expect(WialonApi::Result).to receive(:extract_result).with(response)
      WialonApi::Result.process(response, nil)
    end

    context 'with a non-enumerable result' do
      let(:type) { double('Type') }
      let(:value) { double('value') }

      context 'when block_given?' do
        it 'yields the #typecast-ed value and returns the result of the block' do
          block_result = double('Block result')
          expect(result).to receive(:result_method).and_return(block_result)
          block = proc(&:result_method)

          expect(WialonApi::Result.process(response, block)).to eq(block_result)
        end
      end
    end

    context 'with an enumerable result' do
      let(:element1) { double('First element') }
      let(:element2) { double('Second element') }
      let(:enumerable_result) { [element1, element2] }

      before(:each) do
        allow(WialonApi::Result).to receive(:extract_result).and_return(enumerable_result)
      end

      it 'returns the untouched value' do
        expect(WialonApi::Result.process(enumerable_result, nil)).to eq(enumerable_result)
      end

      context 'when block_given?' do
        it 'yields each element untouched to the block' do
          result1 = double('First element after result_method')
          result2 = double('Second element after result_method')
          expect(element1).to receive(:result_method).and_return(result1)
          expect(element2).to receive(:result_method).and_return(result2)
          block = proc(&:result_method)

          expect(WialonApi::Result.process(enumerable_result, block)).to eq([result1, result2])
        end
      end
    end
  end

  describe '.extract_result' do
    let(:result_response) do
      { 'key' => 'value' }
    end

    let(:result_error) do
      {
        'request_params' => [
          {
            'key'   => 'error',
            'value' => 'description'
          }
        ]
      }
    end

    context 'with a success response' do
      let(:result) { Hashie::Mash.new(result_response) }
      it 'returns plain result' do
        expect(WialonApi::Result.send(:extract_result, result)).to eq(result)
      end
    end

    context 'with an error response' do
      let(:result) { Hashie::Mash.new(error: result_error) }

      it 'raises a WialonApi::Error' do
        expect do
          WialonApi::Result.send(:extract_result, result)
        end.to raise_error(WialonApi::Error)
      end
    end
  end
end
