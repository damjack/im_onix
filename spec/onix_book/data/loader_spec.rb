require 'spec_helper'

describe OnixBook::Data::Loader do
  it 'get ref_names' do
    expect(code_lists).not_to be nil
  end

  it 'get hash' do
    expect(code_lists21).not_to be nil
  end
end
