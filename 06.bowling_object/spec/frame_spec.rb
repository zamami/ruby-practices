# frozen_string_literal: true

require_relative '../lib/frame'

RSpec.describe Frame do
  it 'フレームのスコア' do
    expect(Frame.new('1', '8').score).to eq 9
    expect(Frame.new('X').score).to eq 10
  end

  it 'ストライク？' do
    expect(Frame.new('X').strike?).to eq true
  end

  it 'スペア？' do
    expect(Frame.new('2', '8').score).to eq 10
  end
end
