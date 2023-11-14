# frozen_string_literal: true

require_relative 'file_info'
class LsLongOption
  def initialize(file_lists)
    @file_lists = file_lists
    @long_option = FileInfo.new(file_lists) # 依存オブジェクトの注入
  end

  def show
    puts "total #{@long_option.stat_blocks_total}"
    @long_option.show
  end
end
