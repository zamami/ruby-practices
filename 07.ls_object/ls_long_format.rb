# frozen_string_literal: true

require_relative 'ls_file_info'
class LsLongFormat
  def initialize(file_list)
    @file_list = file_list
    @file_list_info = LsFileInfo.new(file_list)
  end

  def show
    stat_blocks_total
    file_list_info
  end

  private

  def stat_blocks_total
    puts "total #{@file_list_info.stat_blocks_total}"
  end

  def file_list_info
    file_list_info = @file_list_info.filename_info
    file_list_info.each do |file_info|
      p file_info
    end
  end
end
