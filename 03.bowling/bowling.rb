# !/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')

# 数字に変換
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
  else
    shots << s.to_i
  end
end

point = 0
index = 0
10.times do |frame|
  if shots[index] == 10 # ストライクの時
    point += shots[index..index + 2].sum
    index += 1
  elsif shots[index..index + 1].sum == 10 # スペアの時
    point += shots[index..index + 2].sum
    index += 2
  elsif shots[index..index + 1].sum < 10 # ストライクとスペア以外
    point += shots[index..index + 1].sum
    index += 2
  end
end

p point
