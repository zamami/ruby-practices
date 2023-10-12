# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(shots)
    @shots = shots
    @frames = []
    index = 0

    10.times do
      @frames << Frame.new(@shots[index], @shots[index + 1], @shots[index + 2])
      index += @frames.last.strike? ? 1 : 2
    end
  end

  def frame_scores
    frame_scores = []
    index = 0
    @frames.each do |frame|
      frame_score = frame.score
      frame_scores << frame_score
      index += frame.strike? ? 1 : 2
    end
    frame_scores
  end

  def score
    frame_scores.sum
  end
end
