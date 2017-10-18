# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
					@store = Array.new(length)
					@capacity = length
  end

  # O(1)
  def [](index)
					validate_index index
					@store[index]
  end

  # O(1)
  def []=(index, value)
					validate_index index
					@store[index] = value
  end

  protected
  attr_accessor :store

	def validate_index(index)
					throw "index out of bounds" unless index < @capacity
	end
end
