# frozen_string_literal: true

require_relative 'ls_option_parser'
require_relative 'ls_command'
require_relative 'ls_loption'

option_parser = LsOptionParser.new
file_list = option_parser.file_list

option_parser.l_option? ? LsLoption.new(file_list).show : LsCommand.new(file_list).show

