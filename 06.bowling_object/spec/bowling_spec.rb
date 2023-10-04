# frozen_string_literal: true

require_relative '../lib/frame'

RSpec.describe 'bowling.rb' do
  it '全部できること' do
    pattern_1 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    shots = pattern_1.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 139

    pattern_2 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    shots = pattern_2.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 164

    pattern_3 = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    shots = pattern_3.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 107

    pattern_4 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    shots = pattern_4.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 134

    pattern_5 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
    shots = pattern_5.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 144

    pattern_6 = 'X,X,X,X,X,X,X,X,X,X,X,X'
    shots = pattern_6.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 300

    pattern_7 = 'X,0,0,X,0,0,X,0,0,X,0,0,X,0,0'
    shots = pattern_7.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 50

  end
end