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
      index += frame.strike? ? 1 : 2
    end
    frame_scores
  end

  def score
    frame_scores.sum
  end

  private

  def calculate_frame_score(frame, index)
    if frame.strike?
      Frame.new(@shots[index],@shots[index + 1],@shots[index + 2]).score
    elsif frame.spare?
      Frame.new(@shots[index],@shots[index + 1],@shots[index + 2]).score
    else
      Frame.new(@shots[index], @shots[index + 1]).score
    end #frame.score リファクタリング
  end

end



