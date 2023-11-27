# frozen_string_literal: true

require 'optparse'
class LsParser
  def initialize
    @options = ARGV.getopts('alr')
  end

  def filenames
    args = ['*']
    args << File::FNM_DOTMATCH if @options['a']
    @options['r'] ? Dir.glob(*args).sort.reverse : Dir.glob(*args).sort
  end

  def l_option?
    @options['l']
  end
end
