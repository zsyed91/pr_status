require 'spec_helper'

describe 'PrStatus::VERSION' do
  it 'has a version number' do
    expect(PrStatus::VERSION).not_to be nil
  end
end
