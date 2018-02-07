require 'spec_helper'

describe OnixBook::Data::Loader do
  context 'init Loader' do
    let(:loader) { OnixBook::Data::Loader.new }

    it 'get tags' do
      expect(loader.tags).not_to be nil
    end

    it 'get shorts' do
      expect(loader.shorts).not_to be nil
    end

    it 'get hash' do
      expect(loader.hash(14)).not_to be nil
    end
  end
end
