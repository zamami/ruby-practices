# frozen_string_literal: true

class LsNormalFormat
  def initialize(filenames)
    @filenames = filenames
  end

  def show
    max_filenames_size = @filenames.max_by(&:length).size + 1 # ls,ls -arコマンドの見た目を整えるため、配列の中から一番文字数が大きものを見つける。
    resized_filenames = @filenames.map { |filename| filename.ljust(max_filenames_size) }
    column = 3 # column: "列数"
    tolerance = (resized_filenames.size / column.to_f).ceil # tolerance: "公差"
    filenames_slice = resized_filenames.each_slice(tolerance).to_a
    filenames_slice.each { |filename| (tolerance - filename.size).times { filename << nil } }.transpose.each { |filename| puts filename.join } # transposeを使うために足りない要素をnilで埋める。
  end
end
