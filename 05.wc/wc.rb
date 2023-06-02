

total_line_count = 0
total_word_count = 0
total_file_size = 0

def wc(file_path)
  line_count = 0
  word_count = 0
  file_size = 0

  File.open(file_path, 'r') do |file|
    file.each_line do |line|
      line_count += 1
      word_count += line.split.length
      file_size += line.length
    end
  end

  output_format = '%8d%8d%8d %s'
  puts format(output_format, line_count, word_count, file_size, file_path)
end

# コマンドライン引数からファイルパスを取得
file_path = ARGV[0]
# file_path = readlines.map(&:chomp)

# ファイルパスが指定されているか確認
if file_path.nil?
  puts "ファイルパスを指定してください。"
else
  wc(file_path)
end
