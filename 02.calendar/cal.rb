#!/usr/bin/env ruby
require "optparse"
require "date"

opt = OptionParser.new
option = {}
opt.on( "-m ARG", desc = "set month variable" ){ |m| option[:m] = m }
opt.on( "-y ARG", desc = "set year variable" ){ |y| option[:y] = y }
opt.parse(ARGV)

option[:m] ? month = option[:m].to_i : month = Date.today.month
option[:y] ? year = option[:y].to_i : year = Date.today.year

puts "       #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

space  = "   "
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
days_range = (first_date..last_date)
days_range.each do |days_range|
  print space * days_range.wday if days_range.day == 1
  print days_range.day.to_s.rjust(2," ") + " "
  puts "\n" if days_range.saturday?
end
