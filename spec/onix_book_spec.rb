require 'spec_helper'

describe OnixBook do
  it 'has a version number' do
    expect(OnixBook::VERSION).not_to be nil
  end

  context "parse ONIX file" do
    let(:parser) { OnixBook::Parser.new }
    let(:path) { "fixtures/tmp.onix" }

    it "check file is File type" do
      File.open("fixtures/tmp.onix") do |f|
        expect(f).to be_a File
      end
    end

    it "read file" do
      debugger
      expect(parser.analyze(path)).to be_a Hash
    end
  end
end
