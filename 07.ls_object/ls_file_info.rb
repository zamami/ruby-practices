# frozen_string_literal: true

require 'etc'

class LsFileInfo
  FILE_MODE = { '7' => 'rwx', '6' => 'rwx', '5' => 'r-x', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x', '0' => '---' }.freeze

  def initialize(filenames)
    @filenames = filenames
  end

  def format_filenames
    @filenames.map do |filename|
      stat = File.lstat(filename) # ディレクトリの中の要素をfile::lstatに通す
      filename_type = filename_type(stat.ftype) # ファイルタイプを取得
      filename_mode = filename_permission_string(stat.mode) # 下３桁を定義してjoinでくっつける
      filename_type_mode = "#{filename_type}#{filename_mode}  " # ファイルタイプとファイルモードを一つにする
      filename_nlink = stat.nlink.to_s # リンク数を取得
      owner_name = "#{Etc.getpwuid(stat.uid).name} " # オーナー名を取得
      group_name = Etc.getgrgid(stat.gid).name # グループ名を取得
      filename_size = stat.size.to_s.rjust(5) # ファイルサイズを取得
      filename_time = stat.atime.strftime('%_b %_d %R') # ファイルの作成時刻を取得
      filename_path = "-> #{File.readlink(filename)}" if stat.symlink? # シンボリックファイルのリンク先を取得
      [filename_type_mode, filename_nlink, owner_name, group_name, filename_size, filename_time, filename, filename_path].join(' ')
    end
  end

  def stat_blocks_total
    @filenames.sum do |filename|
      File.lstat(filename).blocks
    end
  end

  private

  def filename_type(type)
    if type == 'directory'
      'd'
    elsif type == 'file'
      '-'
    else
      'l'
    end
  end

  def filename_permission_string(mode)
    filename_mode_num = mode.to_s(8).split('').slice(-3..-1) # 下３桁を取得。
    change_filename_mode_num = filename_mode_num.map { |num| FILE_MODE[num] }
    change_filename_mode_num.join
  end
end
