# frozen_string_literal: true

require 'optparse'

files = ARGV
options = ARGV.getopts('lcw')
def output_count?(options, option:)
  options[option] || !options.value?(true)
end

def print_counts(counts, options, path_or_total = '')
  result = ''
  result += counts[:line_count].to_s.rjust(8) if output_count?(options, option: 'l')
  result += counts[:word_count].to_s.rjust(8) if output_count?(options, option: 'w')
  result += counts[:byte_count].to_s.rjust(8) if output_count?(options, option: 'c')
  puts result + path_or_total
end

if !files.empty? # 単数、複数ファイル
  total_counts = { line_count: 0, word_count: 0, byte_count: 0 }
  files.each do |file_path|
    counts = { line_count: 0, word_count: 0, byte_count: 0 }
    File.open(file_path, 'r') do |file|
      file.each_line do |line|
        counts[:line_count] += 1
        counts[:word_count] += line.split.size
        counts[:byte_count] += line.bytesize
      end
    end
    total_counts.transform_values!.with_index { |value, index| value + counts.values[index] }
    print_counts(counts, options, " #{file_path}")
  end
  print_counts(total_counts, options, ' total') if files.size > 1 # total表示
else # 標準入力
  text = $stdin.read
  counts = {
    line_count: text.lines.count,
    word_count: text.split.size,
    byte_count: text.bytesize
  }
  print_counts(counts, options)
end
