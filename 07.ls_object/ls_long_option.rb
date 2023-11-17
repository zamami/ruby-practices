# frozen_string_literal: true

require_relative 'ls_file_info'
class LsLongOption
  def initialize(file_list)
    @file_list = file_list
    @long_option = LsFileInfo.new(file_list) # 依存オブジェクトの注入
  end

  def show
    puts "total #{@long_option.stat_blocks_total}"
    @long_option.show
  end
end
