# 今月のカレンダーを表示するプログラムを書いてみよう。（コマンドラインのプログラムとして作ろう）

# ヒント
# Dateクラスを使えばカレンダーが作れる
# まずは今月の1日と月末の日付と曜日を求める


# とりあえず、今月のカレンダーを作ってみる。
require "date"

date1 = Date.new(2023, 4, 1)
date2 = Date.new(2023, 4, -1)
first_day = date1.wday.to_s
month_days = (date1..date2)

puts "       4月 2023        "
puts "日 月 火 水 木 金 土"
puts ""
month_days.each{|month_day|
space  = "   "
print space * month_day[0].wday if month_day == 1
print month_day.day.to_s.rjust(2," ") + " "
puts "" if month_day.wday == 6

}
binding.irb


# case first_day
# when "0" then
#     print first_day
#     print month_period[1..5].to_s.rjust(18," ")
# when "1" then
#     print
# when "2" then
#     print
# when "3" then
#     print
# when "4" then
#     print
# when "5" then
#     print
# when "6" then
#     print
# end

# 「考えたこと」
# wdayを使って曜日の間隔を数字で指定して、
# その分スペースで移動させる。
# もし、土曜日が1日ならその分スペースで移動させる条件分岐を書く。
# それ以外はスペースをゼロにして詰めて表示していく。
# text.ljust(20,"1234567890")

