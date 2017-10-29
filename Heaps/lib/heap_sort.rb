require_relative 'heap'
require 'byebug'
require 'byebug'

class Array
  def heap_sort!
    # 1. make a heap using the heap
    h = BinaryMinHeap.new
    each {|i| h.push(i)}
    h.store.reverse!
    debugger

    last = h.count - 1
    while last > 0
      # make a max heap
      # heapify up from left to right
      #
      # 2 treat it like a min heap
      # make a barrier in the right hand side
      # heapify down from the left, do not pass the barrier
      # increment the barrier, heapify the next leftmost element
    end
  end
end
