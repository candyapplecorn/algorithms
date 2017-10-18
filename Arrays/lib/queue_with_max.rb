# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
					@store = RingBuffer.new
					@_max = nil
					@length = 0
					@_maxQueue = RingBuffer.new
					# The 1st item in the maxQueue is always the max
  end

	# Whenever adding values, check the last items
	# of the _maxQueue and if they're less than
	# the new item, remove them until there is a
	# greater item or it's empty. Then push the 
	# max item on to the maxQueue
	#
	# 
	#
	def pushToMaxQueue(val)
					loop do
									break if @_maxQueue.length == 0 
									last = @_maxQueue.pop
									if last >= val
													@_maxQueue.push(last)
													break
									end
					end

					@_maxQueue.push(val)
	end
	# When removing an item from the queue, also check to
	# see if it needs to be removed from the maxQueue
	def dequeueMaxQueue(val)
					@_maxQueue.shift if val == @_maxQueue[0]
	end

	def enqueue(val)
					@store.push(val)
					pushToMaxQueue(val)
					@length += 1
					val
	end

	def dequeue
					@length -= 1
					val = @store.shift
					dequeueMaxQueue val
					val
	end

	def max
					@_maxQueue.length > 0 ? @_maxQueue[0] : nil
	end

  def length
					@length
  end
#  def OLDenqueue(val)
#					# whenever enqueue, update max if needed
#					@store.push(val)
#					@_max = [val, (@_max || val - 1)].max
#					@length += 1
#  end

#  def OLDdequeue
#					@length -= 1
#					ret = @store.shift
#
#					if (ret == @_max && @store.length > 0) 
#									nq = RingBuffer.new
#									@_max = @store[0]
#
#									while (@store.length > 0)
#													curr = @store.shift
#													nq.push curr
#													@_max = [curr, @_max].max
#									end
#
#									@store = nq
#					elsif @store.length == 0
#									@_max = nil
#					end
#
#					ret
#  end
#
#  def OLDmax
#					@_max
#  end

end
