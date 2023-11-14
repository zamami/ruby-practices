# frozen_string_literal: true

require_relative 'ls_parser'
require_relative 'ls_command'
require_relative 'ls_long_option'

parser = LsParser.new
file_list = parser.file_list

parser.l_option? ? LsLongOption.new(file_list).show : LsCommand.new(file_list).show
