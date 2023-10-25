# frozen_string_literal: true

require 'etc'
class LsLoption < LsCommand

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
  def show
    stat_blocks_total = []
    lists_values = @lists.map do |list|
      stat = File.lstat(list) # ディレクトリの中の要素をfile::lstatに通す
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
      [file_type_mode, file_nlink, owner_name, group_name, file_size, file_time, list, file_path].join(' ')
    end
    puts "total #{stat_blocks_total.sum}"
    lists_values.each { |list| puts list }
  end
end
