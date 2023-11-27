# frozen_string_literal: true

class LsNormalFormat
  def initialize(filenames)
    @filenames = filenames
  end

  def show
    filenames_max_size = @filenames.max_by(&:length).size + 1 # ls,ls -arコマンドの見た目を整えるため、配列の中から一番文字数が大きものを見つける。
    resize_filenames = @filenames.map { |filename| filename.ljust(filenames_max_size) }
    column = 3 # column: "列数"
    tolerance = (resize_filenames.size / column.to_f).ceil # tolerance: "公差"
    slice_filenames = resize_filenames.each_slice(tolerance).to_a
    slice_filenames.each { |filename| (tolerance - filename.size).times { filename << nil } }.transpose.each { |filename| puts filename.join } # transposeを使うために足りない要素をnilで埋める。
  end
end
