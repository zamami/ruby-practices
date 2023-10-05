# frozen_string_literal: true

require_relative '../lib/game'

RSpec.describe Game do
  describe '10フレームの値を合計してゲームスコアを出す' do
    shots = [6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 9, 1, 8, 0, 10, 6, 4, 5]
    index = 0
    frame_scores = []

    10.times do
      frame = Frame.new(shots[index], shots[index + 1])
      if frame.strike? || frame.spare?
        frame_score = Frame.new(shots[index], shots[index + 1], shots[index + 2]).score
        frame_scores << frame_score
      else
        frame_scores << frame.score
      end
      index += frame.strike? ? 1 : 2
    end
    frame_scores
  end

  describe '現在のフレームがストライクもしくはスペアか判別する' do
    shots = [10, 8, 2, 6, 3]
    context 'ストライクの場合' do
      it 'trueになるのか確認' do
        frame = Frame.new(shots[0], shots[1])
        expect(frame.strike? || frame.spare?).to eq true
      end
    end

    context 'スペアの場合' do
      it 'trueになるのか確認' do
        frame = Frame.new(shots[1], shots[2])
        expect(frame.strike? || frame.spare?).to eq true
      end
    end
  end

  describe 'インデックスに数字を加える' do
    shots = [10, 1, 2]
    context 'ストライクの場合' do
      it 'インデックスに加える数は１' do
        frame = Frame.new(shots[0])
        expect(frame.strike? ? 1 : 2).to eq 1
      end
    end

    context 'ストライクではない場合' do
      it 'インデックスに加える数は２' do
        frame = Frame.new(shots[1])
        expect(frame.strike? ? 1 : 2).to eq 2
      end
    end
  end

  describe 'フレームスコアの計算をする' do
    shots = [10, 8, 2, 6, 3]
    context 'ストライクかスペアの場合' do
      it '現在の投球から２投球先まで合計する' do
        index = 0
        frame = Frame.new(shots[index], shots[index + 1], shots[index + 2])
        expect(frame.score).to eq 20
      end
    end

    context 'それ以外の場合' do
      it '現在の投球と次の投球を合計する' do
        index = 2
        frame = Frame.new(shots[index], shots[index + 1])
        expect(frame.score).to eq 8
      end
    end
  end
end
