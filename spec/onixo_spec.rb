require 'spec_helper'

describe Onixo do
  it 'has a version number' do
    expect(Onixo::VERSION).not_to be nil
  end

  context "parse ONIX 3.0 file" do
    let(:parser) { Onixo::Parser.new }
    let(:path) { "fixtures/tmp.onix" }

    it "check file is File type" do
      File.open("fixtures/tmp.onix") do |f|
        expect(f).to be_a File
      end
    end

    it "read file" do
      expect(parser.analyze(path)).to be_a Hash
    end
  end

  context "parse ONIX 2.1 file" do
    let(:parser) { Onixo::Parser.new }
    let(:path) { "fixtures/tmp_21.onix" }

    it "check file is File type" do
      File.open("fixtures/tmp_21.onix") do |f|
        expect(f).to be_a File
      end
    end

    it "read file" do
      expect(parser.analyze(path)).to be_a Hash
    end
  end
end
