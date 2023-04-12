#!/usr/bin/env ruby
require "optparse"
require "date"

opt = OptionParser.new
option = {}
opt.on( "-m ARG", desc = "set month variable" ){ |m| option[:m] = m }
opt.on( "-y ARG", desc = "set year variable" ){ |y| option[:y] = y }
opt.parse(ARGV)

month = option[:m] ? option[:m].to_i : Date.today.month
year = option[:y] ? option[:y].to_i : Date.today.year

puts "       #{month}月 #{year}"
puts "日 月 火 水 木 金 土"
first_date = Date.new(year, month, 1)
print "   " * first_date.wday
last_date = Date.new(year, month, -1)
date_range = (first_date..last_date)
date_range.each do |date|
  print date.day.to_s.rjust(2," ") + " "
  puts "\n" if date.saturday?
end
