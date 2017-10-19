class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  public
  def self.child_indices(len, parent_index)
					[parent_index * 2 + 1, parent_index * 2 + 2].select {|e| e < len}
  end

  def self.parent_index(child_index)
					raise "root has no parent" if child_index == 0
					(child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
					return array if parent_index > len
					a, b = self.child_indices(parent_index)
					return array if !(a && b)


					if ((a && b) && prc.call(a, b) <= 0)
									self.heapify_down(array, a, len, &prc)
					elsif a && b
									self.heapify_down(array, b, len, &prc)
					elsif a

					elsif b

					end


					if !b
									return self.heapify_down(array, a, len, &prc)
					elsif !a
									return self.heapify_down(array, b, len, &prc)
					end

	end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end

	def self.swap(array, a, b)
					array[a], array[b] = [array[b], array[a]]
					array
	end
end
