#!/usr/bin/env ruby
# １投ごとに分割する
score = ARGV[0]
scores = score.split(',')

# 数字に変換
shots = []
scores.each do |s|
  if s == 'X' #strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

one_four_seven_ten_point_frames = []
shots.each_slice(6) do |s|
    one_four_seven_ten_point_frames << s
end

2.times{ shots.shift }
two_five_eight_point_frames = []
shots.each_slice(6) do |s|
    two_five_eight_point_frames << s
end

2.times{ shots.shift }
three_six_nine_point_frames = []
shots.each_slice(6) do |s|
    three_six_nine_point_frames << s
end

point = 0
one_four_seven_ten_point_frames.each_with_index do |frame, i|
  point += frame.sum if i == one_four_seven_ten_point_frames.length - 1 
  if frame.count == 6 && i != one_four_seven_ten_point_frames.length - 1 
    if frame[0] == 10 && frame[2] == 10 #ストライクの時(20~30得点)
      point += frame[0] + frame[2] + frame[4]
    elsif frame[0] == 10 #ストライクの時（10~19得点）
      point += frame[0] + frame[2] + frame[3]
    elsif frame[0] + frame[1] == 10 #スペアの時
      point += frame[0] + frame[1] + frame[2]
    else
      point += frame[0] + frame[1] #ストライクでもスペアでもない
    end
  end
end

two_five_eight_point_frames.each_with_index do |frame, i|
  if frame.count == 6 && i != two_five_eight_point_frames.length - 1 
    if frame[0] == 10 && frame[2] == 10 #ストライクの時(20~30得点)
      point += frame[0] + frame[2] + frame[4]
    elsif frame[0] == 10 #ストライクの時（10~19得点）
      point += frame[0] + frame[2] + frame[3]
    elsif frame[0] + frame[1] == 10 #スペアの時
      point += frame[0] + frame[1] + frame[2]
    else
      point += frame[0] + frame[1] #ストライクでもスペアでもない
    end
  elsif frame.count == 6 && i == two_five_eight_point_frames.length - 1 
    if frame[0] == 10 && frame[2] == 10 #ストライクの時(20~30得点)
        point += frame[0] + frame[2] + frame[4]
      elsif frame[0] == 10 #ストライクの時（10~19得点）
        point += frame[0] + frame[2] + frame[3]
      elsif frame[0] + frame[1] == 10 #スペアの時
        point += frame[0] + frame[1] + frame[2]
      else
        point += frame[0] + frame[1] #ストライクでもスペアでもない
      end
  end
end

three_six_nine_point_frames.each_with_index do |frame, i|
  if frame.count == 6 && i <= 2
    if frame[0] == 10 && frame[2] == 10 #ストライクの時(20~30得点)
      point += frame[0] + frame[2] + frame[4]
    elsif frame[0] == 10 #ストライクの時（10~19得点）
      point += frame[0] + frame[2] + frame[3]
    elsif frame[0] + frame[1] == 10 #スペアの時
      point += frame[0] + frame[1] + frame[2]
    else
      point += frame[0] + frame[1] #ストライクでもスペアでもない
    end
  elsif frame.count ==5 && i <= 2
    if frame[0] == 10 && frame[2] == 10 #ストライクの時(20~30得点)
      point += frame[0] + frame[2] + frame[4]
    elsif frame[0] == 10 #ストライクの時（10~19得点）
      point += frame[0] + frame[2] + frame[3]
    elsif frame[0] + frame[1] == 10 #スペアの時
      point += frame[0] + frame[1] + frame[2]
    else
      point += frame[0] + frame[1] #ストライクでもスペアでもない
    end
  elsif frame.count ==4 && i <= 2
    if frame[0] == 10 && frame[2] == 10 #ストライクの時(20~30得点)
      point += frame[0] + frame[2] + frame[4]
    elsif frame[0] == 10 #ストライクの時（10~19得点）
      point += frame[0] + frame[2] + frame[3]
    elsif frame[0] + frame[1] == 10 #スペアの時
      point += frame[0] + frame[1] + frame[2]
    else
      point += frame[0] + frame[1] #ストライクでもスペアでもない
    end
  end
end
  
puts point


