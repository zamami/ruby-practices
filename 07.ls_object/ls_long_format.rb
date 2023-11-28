# frozen_string_literal: true

require_relative 'ls_file_info'

class LsLongFormat
  def initialize(filenames)
    @filenames = filenames
    @ls_file_info = LsFileInfo.new(filenames)
  end

  def show
    print_stat_blocks_total
    print_filenames
  end

  private

  def print_stat_blocks_total
    puts "total #{@ls_file_info.stat_blocks_total}"
  end

  def print_filenames
    filenames = @ls_file_info.format_filenames
    filenames.each do |filename|
      p filename
    end
  end
end
