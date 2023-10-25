# frozen_string_literal: true

require_relative 'ls_command'
require_relative 'ls_loption'
require 'optparse'

OPTIONS = ARGV.getopts('alr')
args = ['*']
args << File::FNM_DOTMATCH if OPTIONS.fetch('a', false) # -aオプションがあるのか
lists = OPTIONS['r'] ? Dir.glob(*args).reverse : Dir.glob(*args) # -rオプションがあるのか

OPTIONS['l'] ? LsLoption.new(lists).show : LsCommand.new(lists).show # -lオプションがあるのか
