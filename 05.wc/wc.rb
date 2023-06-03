# frozen_string_literal: true

require 'optparse'

def option_wc(file_path, options)
  line_count = 0
  word_count = 0
  byte_count = 0

  File.open(file_path, 'r') do |file|
    file.each_line do |line|
      line_count += 1 if options['l']
      word_count += line.split.size if options['w']
      byte_count += line.bytesize if options['c']
    end
  end

  result = ''
  result += line_count.to_s.rjust(8) if options['l']
  result += word_count.to_s.rjust(8) if options['w']
  result += byte_count.to_s.rjust(8) if options['c']
  result += " #{file_path}"

  puts result
end

def not_option_wc(files)
  file = { line_count: 0, word_count: 0, file_size: 0 }
  total_file = { line_count: 0, word_count: 0, file_size: 0 }
  output_format = '%8d%8d%8d %s'

  files.each do |file_path|
    text = File.read(file_path)
    file[:line_count] = text.count("\n")
    file[:word_count] = text.split(/\s+/).size
    file[:file_size] = text.bytesize
    puts format(output_format, file[:line_count], file[:word_count], file[:file_size], file_path)

    total_file[:line_count] += text.count("\n")
    total_file[:word_count] += text.split(/\s+/).size
    total_file[:file_size] += text.bytesize
  end

  total_format = '%8d%8d%8d'
  puts "#{format(total_format, total_file[:line_count], total_file[:word_count], total_file[:file_size])} total" if files[1]
end

files = ARGV
options = ARGV.getopts('lcw')

if options.value?(true)
  files.each do |file|
    option_wc(file, options)
  end
else
  not_option_wc(files)
end

