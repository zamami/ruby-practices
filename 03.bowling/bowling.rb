# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

# 数字に変換
shots = []
scores.each do |s|
  shots << if s == 'X'
             10
           else
             s.to_i
           end
end

index = 0
point = 10.times.sum do |_frame|
  if shots[index] == 10 # ストライクの時
    frame_point = shots[index..index + 2]
    index += 1
  elsif shots[index..index + 1].sum == 10 # スペアの時
    frame_point = shots[index..index + 2]
    index += 2
  else
    frame_point = shots[index..index + 1]
    index += 2
  end
  frame_point.sum
end

p point
