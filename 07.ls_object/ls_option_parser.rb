# frozen_string_literal: true

class LsOptionParser
  require 'optparse'

  def initialize
    @options = ARGV.getopts('alr')
  end

  def file_list
    args = ['*']
    args << File::FNM_DOTMATCH if @options['a']
    @options['r'] ? Dir.glob(*args).reverse : Dir.glob(*args)
  end

  def l_option?
    @options['l']
  end
end
