require 'spec_helper'

describe Chef::Development do
  it 'has a version number' do
    expect(Chef::Development::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
