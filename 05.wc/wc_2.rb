# frozen_string_literal: true

files = ARGV
total_file_symbol = { line_count: 0, word_count: 0, file_size: 0 }
file_symbol = { line_count: 0, word_count: 0, file_size: 0 }
output_format = '%8d%8d%8d %s'

files.each do |file|
  text = File.read(file)
  file_symbol[:line_count] = text.count("\n")
  file_symbol[:word_count] = text.split(/\s+/).size
  file_symbol[:file_size] = text.bytesize
  puts format(output_format, file_symbol[:line_count], file_symbol[:word_count], file_symbol[:file_size], file)

  total_file_symbol[:line_count] += text.count("\n")
  total_file_symbol[:word_count] += text.split(/\s+/).size
  total_file_symbol[:file_size] += text.bytesize
end

total_output_format = '%8d%8d%8d'
puts "#{format(total_output_format, total_file_symbol[:line_count], total_file_symbol[:word_count], total_file_symbol[:file_size])} total" if files[1]
