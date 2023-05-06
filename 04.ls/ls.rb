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
files = Dir.glob(*args)
# -rオプションに対応
files = files.reverse if options['r']

# -lオプションに対応。
total = []
hash_files = []

def get_ftype(ftype)
  if ftype == 'directory'
    'd'
  elsif ftype == 'file'
    '-'
  else
    'l'
  end
end

def get_file_mode(stat_mode)
  get_file_mode_num = stat_mode.to_s(8).split('').slice(-3..-1) # 下３桁を取得。
  file_mode = { '7' => 'rwx',
                '6' => 'rwx',
                '5' => 'r-x',
                '4' => 'r--',
                '3' => '-wx',
                '2' => '-w-',
                '1' => '--x',
                '0' => '---' }
  change_file_mode_num = get_file_mode_num.map { |num| file_mode[num] }
  change_file_mode_num.join
end

files.each do |file|
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
  total << stat.blocks # ブロックサイズを取得
  file_hash = { file_type_mode: file_type_mode.to_s,
                file_nlink: file_nlink.to_s,
                owner_name: owner_name.to_s,
                group_name: group_name.to_s,
                file_size: file_size.to_s,
                file_time: file_time.to_s,
                file_name: file,
                file_path: file_path.to_s }
  hash_files << file_hash.values.join(' ')
end

puts "total #{total.sum}"
hash_files.each { |file| puts file }

# ls,ls -arコマンドの見た目を整えるため、配列の中から一番文字数が大きものを見つける。
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

# colum_resize_files.transpose.each { |file| puts file.join }
