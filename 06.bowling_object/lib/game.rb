# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(shots)
    @shots = shots
  end

  def frame_scores
    index = 0
    frame_scores = []

    10.times do
      frame = Frame.new(@shots[index], @shots[index + 1])
      frame_score = calculate_frame_score(frame, index)
      frame_scores << frame_score
      index += add_index(frame)
    end
    frame_scores
  end

  def score
    frame_scores.sum
  end

  private

  def add_index(frame)
    frame.strike? ? 1 : 2
  end

  def strike_or_spare?(frame)
    frame.strike? || frame.spare?
  end

  def add_next_frame_score(index)
    Frame.new(@shots[index], @shots[index + 1], @shots[index + 2]).score
  end

  def calculate_frame_score(frame, index)
    if strike_or_spare?(frame)
      add_next_frame_score(index)
    else
      frame.score
    end
  end

end



