# frozen_string_literal: true

require_relative '../lib/shot'

RSpec.describe Shot do
  it 'scoreがXの時、10を返す' do
    expect(Shot.new('X').score).to eq 10
  end
  it 'scoreが1~9の時、その数字を返す' do
    expect(Shot.new(1).score).to eq 1
  end
end
