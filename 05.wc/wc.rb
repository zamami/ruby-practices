# frozen_string_literal: true

require 'optparse'

files = ARGV
options = ARGV.getopts('lcw')

def option_wc_total(options, counts)
  result = ''
  result += counts[:line_count].to_s.rjust(8) if options['l']
  result += counts[:word_count].to_s.rjust(8) if options['w']
  result += counts[:byte_count].to_s.rjust(8) if options['c']
  result += ' total'
  puts result
end

def option_word_count(files, options)
  total_counts = { line_count: 0, word_count: 0, byte_count: 0 }

  files.each do |file_path|
    counts = { line_count: 0, word_count: 0, byte_count: 0 }
    File.open(file_path, 'r') do |file|
      file.each_line do |line|
        counts[:line_count] += 1 if options['l']
        counts[:word_count] += line.split.size if options['w']
        counts[:byte_count] += line.bytesize if options['c']

        total_counts[:line_count] += 1
        total_counts[:word_count] += line.split.size
        total_counts[:byte_count] += line.bytesize
      end

      result = ''
      result += counts[:line_count].to_s.rjust(8) if options['l']
      result += counts[:word_count].to_s.rjust(8) if options['w']
      result += counts[:byte_count].to_s.rjust(8) if options['c']
      result += " #{file_path}"
      puts result
    end
  end

  option_wc_total(options, total_counts) if files.size > 1
end

def word_count(files)
  output_format = '%8d%8d%8d %s'
  total_file = { line_count: 0, word_count: 0, file_size: 0 }

  files.each do |file_path|
    text = File.read(file_path)
    line_count = text.count("\n")
    word_count = text.split(/\s+/).size
    file_size = text.bytesize

    puts format(output_format, line_count, word_count, file_size, file_path)

    total_file[:line_count] += line_count
    total_file[:word_count] += word_count
    total_file[:file_size] += file_size
  end

  if files.size > 1
    total_format = '%8d%8d%8d'
    puts "#{format(total_format, total_file[:line_count], total_file[:word_count], total_file[:file_size])} total"
  end
end

def standard_input_word_count
  text = $stdin.read
  line_count = text.lines.count
  word_count = text.split.size
  byte_count = text.bytesize

  result = [
    line_count.to_s.rjust(8),
    word_count.to_s.rjust(8),
    byte_count.to_s.rjust(8)
  ].join

  puts result
end

if options.value?(true)
  option_word_count(files, options)
elsif files[0]
  word_count(files)
else
  standard_input_word_count
end
