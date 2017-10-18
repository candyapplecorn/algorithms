require_relative 'p02_hashing'
require_relative 'p01_int_set'

class HashSet < ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    @count += 1
    self[key.hash % num_buckets] << key
    resize! if @count > @num_buckets
  end

  def include?(key)
    !!@store[key.hash % num_buckets].include?(key )
  end

  def remove(key)
    @count -= 1
    self[key.hash % num_buckets].reject! {|it| it == key }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end
  def []=(num, val)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets] = val
  end

  def num_buckets
    @store.length
  end

  def resize!
    ri = HashSet.new(@num_buckets * 2)
    @store.flatten.each {|n| ri.insert n }
    @store = ri.store
  end
end
