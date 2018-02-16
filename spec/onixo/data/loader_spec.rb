require 'spec_helper'

describe Onixo::Data::Loader do
  context 'init Loader' do
    let(:loader) { Onixo::Data::Loader.new }

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
