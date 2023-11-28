# frozen_string_literal: true

require_relative 'ls_parser'
require_relative 'ls_normal_format'
require_relative 'ls_long_format'

ls_parser = LsParser.new
filenames = ls_parser.format_filenames
ls_parser.l_option? ? LsLongFormat.new(filenames).show : LsNormalFormat.new(filenames).show
