# frozen_string_literal: true

require_relative 'ls_file_info'
class LsLongFormat
  def initialize(filenames)
    @filenames = filenames
    @filenames_info = LsFileInfo.new(filenames)
  end

  def show
    stat_blocks_total
    filenames_info
  end

  private

  def stat_blocks_total
    puts "total #{@filenames_info.stat_blocks_total}"
  end

  def filenames_info
    filenames_info = @filenames_info.filename_info
    filenames_info.each do |filename|
      p filename
    end
  end
end
