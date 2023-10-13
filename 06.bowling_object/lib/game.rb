# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(shots)
    @shots = shots
    index = 0
    @frames = Array.new(10) do
      frame = Frame.new(@shots[index], @shots[index + 1], @shots[index + 2])
      index += frame.strike? ? 1 : 2
      frame
    end
  end

  def frame_scores
    @frames.map(&:score)
  end

  def score
    frame_scores.sum
  end
end
