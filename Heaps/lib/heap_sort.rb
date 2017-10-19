require_relative 'heap'
require 'byebug'

class Array
  def heap_sort!
		maxPrc = Proc.new {|a, b| b <=> a}

		each_index {|i| BinaryMinHeap.heapify_up(self, length - 1 - i, length, &maxPrc) }

		counter = 0
		while counter < self.length / 2
			#BinaryMinHeap.heapify_down(self, counter, length - 1 - counter)
			counter += 1
		end

		(length).times do |i|
			BinaryMinHeap.swap(self, 0, length - 1 - i)
			BinaryMinHeap.heapify_down(self, 0, length - 1 - i, &maxPrc)

		end
	end
end
