class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = array.select {|num| num < pivot}
    right = array.select {|num| num > pivot}
    sort1(left) + pivot + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return array if length < 2

    pivot_idx = partition(array, start, length, &prc)

    left_len = pivot_idx - start
    right_len = length - (left_len + 1)
    sort2!(array, start, left_len, &prc)
    sort2!(array, pivot_idx + 1, right_len, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    pivot_idx = start
    pivot = array[start]

    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        
        array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]

    pivot_idx
  end
end
