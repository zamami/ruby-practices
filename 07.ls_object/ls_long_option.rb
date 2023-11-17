# frozen_string_literal: true

require_relative 'ls_file_info'
class LsLongOption
  def initialize(file_list)
    @file_list = file_list
    @file_list_info = LsFileInfo.new(file_list)
  end

  def show
    puts "total #{@file_list_info.stat_blocks_total}"
    @file_list_info.show
  end
end
