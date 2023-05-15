# frozen_string_literal: true

# !/usr/bin/env ruby
require 'optparse'
require 'etc'

input = ARGV
options = ARGV.getopts('alr')

# まずはディレクトリの中身を配列に格納
# オプションに'a’があれば全取得、なければ隠しフォルダは除く
args = ['*']
args << File::FNM_DOTMATCH if options.fetch('a', false)

# -rオプションに対応
reverse_order = options['r']
files = Dir.glob(*args)
FILES = reverse_order ? files.reverse : files

# -lオプションに対応。
def get_ftype(ftype)
  if ftype == 'directory'
    'd'
  elsif ftype == 'file'
    '-'
  else
    'l'
  end
end

FILE_MODE = { '7' => 'rwx', '6' => 'rwx', '5' => 'r-x', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x', '0' => '---' }.freeze
def get_file_mode(stat_mode)
  get_file_mode_num = stat_mode.to_s(8).split('').slice(-3..-1) # 下３桁を取得。
  change_file_mode_num = get_file_mode_num.map { |num| FILE_MODE[num] }
  change_file_mode_num.join
end

def ls_list_files
  stat_blocks_total = []
  file_values = FILES.map do |file|
    stat = File.lstat(file) # ディレクトリの中の要素をfile::lstatに通す
    ftype = get_ftype(stat.ftype) # ファイルタイプを取得
    file_mode = get_file_mode(stat.mode) # 下３桁を定義してjoinでくっつける
    file_type_mode = "#{ftype}#{file_mode}  " # ファイルタイプとファイルモードを一つにする
    file_nlink = stat.nlink.to_s # リンク数を取得
    owner_name = "#{Etc.getpwuid(stat.uid).name} " # オーナー名を取得
    group_name = Etc.getgrgid(stat.gid).name # グループ名を取得
    file_size = stat.size.to_s.rjust(5) # ファイルサイズを取得
    file_time = stat.atime.strftime('%_m %_d %R') # ファイルの作成時刻を取得
    file_path = "-> #{File.readlink(file)}" if stat.symlink? # シンボリックファイルのリンク先を取得
    stat_blocks_total << stat.blocks # ブロックサイズを取得
    file_value = [file_type_mode, file_nlink, owner_name, group_name, file_size, file_time, file, file_path]
    file_value.join(' ')
  end
  puts "total #{stat_blocks_total.sum}"
  file_values.each { |file| puts file }
end

# -lオプションが含まれていない時
files_max_size = FILES.max_by(&:length).size + 1 # ls,ls -arコマンドの見た目を整えるため、配列の中から一番文字数が大きものを見つける。
RESIZE_FILES = FILES.map { |file| file.ljust(files_max_size) }
# 見た目を整える
def format_appearance
  column = 3 # column: "列数"、
  tolerance = (RESIZE_FILES.size / column.to_f).ceil # tolerance: "公差"
  slice_files = RESIZE_FILES.each_slice(tolerance).to_a
  add_nil_to_files = slice_files.each { |file| (tolerance - file.size).times { file << nil } }
  add_nil_to_files.transpose.each { |file| puts file.join } # transposeを使うために足りない要素をnilで埋める。
end

if options['l']
  ls_list_files
else
  format_appearance
end
