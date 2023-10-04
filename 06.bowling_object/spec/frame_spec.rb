# frozen_string_literal: true

require_relative '../lib/frame'

RSpec.describe Frame do
  it 'フレームの計算' do
    expect(Frame.new("1","8").score).to eq 9
    expect(Frame.new("X","0").score).to eq 10
  end
end