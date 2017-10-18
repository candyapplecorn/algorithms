require 'byebug'
require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new      # DOES NOT MAINTAIN ORDER; HAS FAST ACCESS TIME
    @store = LinkedList.new # MAINTAINS ORDER
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    val = @map.getNode(key)
    if val
			# update the linked list
			# return the value
			update_node!(val)
    else
			# insert into linked list
			# insert into map
			val = calc!(key)
			eject! if @max < count
    end
    val.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @map.set(key, @prc.call(key))
		@store.append(key, val)
		val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
		@store.append(node.key, node.val)
  end

  def eject!
		removeThis = @store.first.val.key
		@map.delete(removeThis)
		@store.remove(removeThis)
  end
end
