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
    val = @map.get(key)
    if val
      #update_node!()
    else
      val = @map.set(key, @prc.call(key))
    end
    val.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key

  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
  end
end
