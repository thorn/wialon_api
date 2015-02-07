require 'spec_helper'

describe WialonApi::Namespace do
  describe '.names' do
    before(:each) do
      WialonApi::Namespace.instance_variable_set(:@names, nil)
    end

    context 'on first call' do
      it 'loads namespaces from a file' do
        filename = double('Filename')
        expect(File).to receive(:expand_path).and_return(filename)
        namespaces = double('Namespaces list')
        expect(YAML).to receive(:load_file).with(filename).and_return(namespaces)

        WialonApi::Namespace.names
      end
    end

    context 'on subsequent calls' do
      before(:each) do
        WialonApi::Namespace.names
      end

      it 'returns the cached list' do
        expect(YAML).not_to receive(:load_file)
        WialonApi::Namespace.names
      end
    end
  end

  describe '.exists?' do
    context 'with an existing namespace' do
      it 'returns true' do
        expect(WialonApi::Namespace).to exist('core')
      end
    end

    context 'with a non-existent namespace' do
      it 'returns false' do
        expect(WialonApi::Namespace).not_to exist('wrong')
      end
    end

    context 'with an existing symbol namespace' do
      it 'returns true' do
        expect(WialonApi::Namespace).to exist(:user)
      end
    end
  end
end
