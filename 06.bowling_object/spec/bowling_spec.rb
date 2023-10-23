# frozen_string_literal: true

require_relative '../lib/frame'

RSpec.describe 'bowling.rb' do
  it '全部できること' do
    pattern1 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    shots = pattern1.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 139

    pattern2 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    shots = pattern2.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 164

    pattern3 = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    shots = pattern3.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 107

    pattern4 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    shots = pattern4.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 134

    pattern5 = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
    shots = pattern5.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 144

    pattern6 = 'X,X,X,X,X,X,X,X,X,X,X,X'
    shots = pattern6.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 300

    pattern7 = 'X,0,0,X,0,0,X,0,0,X,0,0,X,0,0'
    shots = pattern7.split(',')
    game = Game.new(shots)
    expect(game.score).to eq 50
  end
end
