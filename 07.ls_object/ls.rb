# frozen_string_literal: true

require_relative 'ls_parser'
require_relative 'ls_normal_format'
require_relative 'ls_long_format'

parser = LsParser.new
file_list = parser.file_list

parser.l_option? ? LsLongFormat.new(file_list).show : LsLongFormat.new(file_list).show
