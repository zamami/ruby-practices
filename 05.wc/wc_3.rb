files = ARGV

total_lines = 0
total_words = 0
total_size = 0

line_count = 0
word_count = 0
file_size = 0

output_format = '%8d%8d%8d %s'

files.each do |file|
  text = File.read(file)

  line_count = text.count("\n")
  word_count = text.split(/\s+/).size
  file_size = text.bytesize

  total_lines += text.count("\n")
  total_words += text.split(/\s+/).size
  total_size += text.bytesize

  puts format(output_format, line_count, word_count, file_size, file)
end

total_output_format = '%8d%8d%8d'
if files[1]
  puts "#{format(total_output_format, line_count, word_count, file_size)} total"
end
