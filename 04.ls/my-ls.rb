# frozen_string_literal: true

# まずはDirメソッドで、ディレクトリ内の情報を取ってきて配列に入れる。 ok
# 配列に入れた情報を指定の条件で表示する。
# Terminalのlsコマンドの動きを観察すると、どうもファイル名の長さに応じて表示方法を変えているように見える。
# ファイル名の文字数がターミナルの横幅に１列で収まるかどうかで改行するかどうか判別されているっぽい。

# つまり、全体の要素の文字数がTerminalのwidthよりも小さければ、１行表示。
# 全体の要素の文字数がTerminalのwidthよりも大きければ要素の２番目を１列目に移動。
# 再度残りの要素の合計幅を見てTerminalのwidthよりも大きいのかどうか繰り返し処理して、
# 表示をしている。
# １、Terminalのwidthを取得する。
# ２、配列の全体の文字数を合計してwidthを計算する。
# ３、配列の全体の文字数がTerminalのwidtよりも小さい場合１行表示
# ４、配列の全体の文字数がTerminalのwidthよりも大きい場合要素を列表示させる。

require 'optparse' # オプション

# まずはディレクトリの中身を配列に格納
files = []
Dir.foreach('.') do |file|
  next if file == '.' or file == '..'
  files << file
end

# lsコマンドの見た目を整えるため、配列の中から一番文字数が大きものを見つける。
files_string_size = []
files.each do |file|
  files_string_size << file.size
end

supace_size  = files_string_size.max + 1
resize_files = []
files.each do |file|
   resize_files<< file.ljust(supace_size)
end

column = 3 #column: "列数"、tolerance: "公差"
tolerance = (resize_files.size / column).ceil

# resize_files.select{_1 % tolerance == 1}
p resize_files


# できたこと
# 等差数列を使って３列表示するために必要な数字をとることができた。
# 配列の数
# 公差

# やりたいこと。
# 公差と配列の数を使って。配列の中から値を抜き取りprint表示したい。
# print表示した要素は配列から削除する。



