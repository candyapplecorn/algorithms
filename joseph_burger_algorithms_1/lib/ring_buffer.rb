require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
					@store = StaticArray.new(8)
					@capacity = 8
					@length = 0
					@start_idx = 0
  end

  # O(1)
  def [](index)
					raise "index out of bounds" if index >= @length
					idx = check_index(index)
					@store[idx]
  end

  # O(1)
  def []=(index, val)
					#raise "index out of bounds" if index >= @length
					idx = check_index(index)
					@store[idx] = val
  end

  # O(1)
  def pop
					raise "index out of bounds" if @length == 0
					@length -= 1
					ret = @store[check_index(@length)]
  end

  # O(1) ammortized
  def push(val)
					resize! if @length == @capacity
					ret = @store[(@start_idx + @length) % @capacity] = val
					@length += 1
					ret
  end

  # O(1)
  def shift
					raise "index out of bounds" if @length == 0
					@length -= 1
					@start_idx = @start_idx + 1
					@store[(@start_idx - 1) % @capacity]
  end

  # O(1) ammortized
  def unshift(val)
					@length += 1
					resize! if @length > @capacity
					@start_idx = (@start_idx - 1) % @capacity
					@store[@start_idx % @capacity] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
					(index + @start_idx) % @capacity
  end

  def resize!
					newStore = StaticArray.new(@capacity * 2)
					counter = 0

					while (counter < @length)# - 1)
									newStore[counter] = @store[check_index(counter)] 
									counter += 1
					end

					@capacity *= 2
					@start_idx = 0
					@store = newStore
  end

  def resize_old!
					@capacity *= 2
					newStore = StaticArray.new(@capacity)
					idx = @start_idx
					counter = 0

					while (counter < @length - 1)
									newStore[counter] = @store[check_index(idx)] 
									counter += 1
									idx += 1
					end

					@start_idx = 0
					@store = newStore
  end
end
