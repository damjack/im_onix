require 'spec_helper'

describe OnixBook::Helpers::Converter do
  let(:file) { 'tmp.onix' }
  before(:each) { touch(file) }

  it { expect(file).to be_an_existing_file }
end
