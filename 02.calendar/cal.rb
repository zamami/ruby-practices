# 今月のカレンダーを表示するプログラムを書いてみよう。（コマンドラインのプログラムとして作ろう）

# ヒント
# Dateクラスを使えばカレンダーが作れる
# まずは今月の1日と月末の日付と曜日を求める


# とりあえず、今月のカレンダーを作ってみる。
require "date"

year = 2023
month = 4
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
range_days = (first_date..last_date)
space  = "   "

puts "       #{month}月 #{year}        "
puts "日 月 火 水 木 金 土"
range_days.each{|range_day|
print space * range_day.wday if range_day.day == 1
print range_day.day.to_s.rjust(2," ") + " "
puts "\n" if range_day.wday == 6

}
# binding.irb


# 「考えたこと」
# wdayを使って曜日の間隔を数字で指定して、
# その分スペースで移動させる。
# もし、土曜日が1日ならその分スペースで移動させる条件分岐を書く。
# それ以外はスペースをゼロにして詰めて表示していく。
# text.ljust(20,"1234567890")

