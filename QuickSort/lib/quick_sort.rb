require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
		return array unless length > 1
		pivot = self.partition(array, start, length, &prc)

		self.sort2!(array, start, pivot - start, &prc)
		self.sort2!(array, pivot + 1, length - pivot - 1, &prc)

		array
  end

  def self.partition(array, start, length, &prc)
		prc ||= Proc.new {|a, b| a <=> b} # Default proc

		pivot = array[start]
		wall = start + 1

		wall.upto(start + length - 1) do |counter|
			current = array[counter]				# Get the current item

			if prc.call(current, pivot) < 0 # Compare it to the pivot
				#1 swap rightof with counter	
				self.swap!(array, counter, wall)

				#2 move the wall up by one
				wall += 1
			end
		end

		#self.swap!(array, wall, start)
		self.swap!(array, wall - 1, start)

		# And return the index of the wall so the quicksort algo
		# knows how to send more partitions
		#wall
		wall - 1
  end

	def self.swap!(array, a, b)
		array[a], array[b] = [array[b], array[a]]
	end
end

def kth_smallest(arr, k, start = 0, len = arr.length, &prc)
	piv = QuickSort.partition(arr, start, len, &prc)

	return arr[piv] if piv == k - 1

	if (k - 1 < piv)
		kth_smallest(arr, k, start, piv - start, &prc)
	else
		kth_smallest(arr, k, piv + 1, len - piv, &prc)
	end
end

#p kth_smallest([1, 2, 3, 4, 5], 2)
#p kth_smallest([1, 2, 3, 4, 5], 1)
#p kth_smallest([1, 2, 3, 4, 5], 0)
