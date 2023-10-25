# frozen_string_literal: true

# lsコマンドの債務を分ける。
# １、これまでの処理を見返してどのような債務があるか把握する。
# ２、必要であればクラスで役割分担して債務を振り分ける。
# 3,実行ファイルを作成してそれぞれの役割の処理を実行する。
# ４、
#
# ls.rb
# インプット、アウトプット担当
#
# ls_command.rb
# 通常のlsコマンドの表示を担当
#
# ls_option.rb
# lオプションの表示を担当


require_relative 'ls_command'
require 'optparse'

OPTIONS = ARGV.getopts('alr')
args = ['*']
args << File::FNM_DOTMATCH if OPTIONS.fetch('a', false) # -aオプションがあるのか
file_data = OPTIONS['r'] ? Dir.glob(*args).reverse : Dir.glob(*args) # -rオプションがあるのか

OPTIONS['l'] ? LsOption.new(file_data).show : LsCommand(file_data).show # -lオプションがあるのか