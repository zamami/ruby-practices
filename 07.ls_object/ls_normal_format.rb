# frozen_string_literal: true

class LsNormalFormat
  def initialize(list)
    @list = list
  end

  def show
    lists_max_size = @list.max_by(&:length).size + 1 # ls,ls -arコマンドの見た目を整えるため、配列の中から一番文字数が大きものを見つける。
    resize_lists = @list.map { |list| list.ljust(lists_max_size) }
    column = 3 # column: "列数"
    tolerance = (resize_lists.size / column.to_f).ceil # tolerance: "公差"
    slice_lists = resize_lists.each_slice(tolerance).to_a
    slice_lists.each { |list| (tolerance - list.size).times { list << nil } }.transpose.each { |list| puts list.join } # transposeを使うために足りない要素をnilで埋める。
  end
end
