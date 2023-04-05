require "optparse"
require "date"

opt = OptionParser.new
option = {}
opt.on( "-m ARG", desc = "set month variable" ){ |m| option[:m] = m }
opt.on( "-y ARG", desc = "set year variable" ){ |y| option[:y] = y }
opt.parse(ARGV)

if option[:m] != nil
  month = option[:m].to_i
else
  month = Date.today.month
end

if option[:y] != nil
    year = option[:y].to_i
  else
    year = Date.today.year
end

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
