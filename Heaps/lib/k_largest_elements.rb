require_relative 'heap'

def k_largest_elements(array, k)
	bh = BinaryMinHeap.new {|a, b| b <=> a}

	array.each {|i| bh.push(i) }
	
	largest = []
	until largest.length == k
		largest << bh.extract
	end
	largest
end
