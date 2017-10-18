require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max
    @store = []
  end

  def insert(num)
    if is_valid? num
      @store[num] = num
    else
      raise "Out of bounds"
    end

    !!@store[num]
  end

  def remove(num)
    @store[num] = nil if is_valid? num
  end

  def include?(num)
    !!@store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push num unless self[num].include? num
  end

  def remove(num)
    self[num].reject! {|n| n == num }
  end

  def include?(num)
    self[num].include? num
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet < IntSet
  attr_reader :count,   :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    super
    @count += 1
    resize! if @count > @num_buckets
  end

  def remove(num)
    super
    @count -= 1
  end

  def include?(num)
    super
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    super
  end

  def num_buckets
    @store.length
  end

  def resize!
    ri = ResizingIntSet.new(@num_buckets * 2)
    @store.flatten.each {|n| ri.insert n }
    @store = ri.store
  end
end
