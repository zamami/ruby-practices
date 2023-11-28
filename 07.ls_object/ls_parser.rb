# frozen_string_literal: true

require 'optparse'

class LsParser
  def initialize
    @options = ARGV.getopts('alr')
  end

  def format_filenames
    filenames = ['*']
    filenames << File::FNM_DOTMATCH if @options['a']
    @options['r'] ? Dir.glob(*filenames).sort.reverse : Dir.glob(*filenames).sort
  end

  def l_option?
    @options['l']
  end
end
