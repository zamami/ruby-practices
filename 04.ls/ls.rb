# frozen_string_literal: true

# !/usr/bin/env ruby
require 'optparse'

input = ARGV
options = ARGV.getopts('alr')

# まずはディレクトリの中身を配列に格納
# オプションに'a’があれば全取得、なければ隠しフォルダは除く
files = if options['a']
          Dir.foreach('.')
        else
          Dir.foreach('.').select { |file| file.start_with?(/\w/) }
        end

# lsコマンドの見た目を整えるため、配列の中から一番文字数が大きものを見つける。
files_max_size = files.max_by(&:length).size + 1
resize_files = files.map { |file| file.ljust(files_max_size) }

column = 3 # column: "列数"、tolerance: "公差"
def get_tolerance(resize_files, column)
  (resize_files.size / column.to_f).ceil
end

tolerance = get_tolerance(resize_files, column)
colum_resize_files = resize_files.each_slice(tolerance).to_a
colum_resize_files.each do |file| # transposeを使うために足りない要素をnilで埋める。
  (tolerance - file.size).times { file << nil }
end

colum_resize_files.transpose.each { |file| puts file.join }
