class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new {|a, b| a <=> b }
  end

  def count
    @store.length
  end

  def extract
    self.class.swap(@store, 0, count - 1)
    ret = @store.pop
    @store = self.class.heapify_down(@store, 0, count, &@prc)
    ret
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    @store = self.class.heapify_up(@store, @store.length - 1, count, &@prc)
  end

  public

  def self.child_indices(len, pi)
    [pi * 2 + 1, pi * 2 + 2].select { |e| e < len }
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|a, b| a <=> b }
    a, b = child_indices(len, parent_idx)
    ai = array[a] if a
    bi = array[b] if b
    curr = array[parent_idx]

    if !(a || b) || parent_idx > len          # no children or too far
      return array
    elsif !a && prc.call(bi, curr) < 0#bi < curr                       # if there is no a and b is less
      self.swap(array, b, parent_idx)
      heapify_down(array, b, len, &prc)
    elsif !b && prc.call(ai, curr) < 0#ai < curr                       # if there is no b and a is less
      self.swap(array, a, parent_idx)
      heapify_down(array, a, len, &prc)
    elsif a && b && prc.call(ai, bi) < 0 && prc.call(ai, curr) < 0#ai < bi && ai < curr        # if there's a and b, and ai is the least
      self.swap(array, a, parent_idx)
      heapify_down(array, a, len, &prc)
    elsif a && b && prc.call(bi, ai) < 0 && prc.call(bi, curr) < 0#ai > bi && bi < curr        # if there's a and b, and bi is the least
      self.swap(array, b, parent_idx)
      heapify_down(array, b, len, &prc)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|a, b| a <=> b }
    debugger unless 
    begin
      pi = self.parent_index(child_idx)
    rescue
      return array
    end

    return array unless pi >= 0 && len >= 0
    at = array[pi]
    curr = array[child_idx]

    if prc.call(curr, at) < 0
      self.swap(array, child_idx, pi)
      self.heapify_up(array, pi, len, &prc)
    end

    array
  end

  def self.swap(array, a, b)
    array[a], array[b] = [array[b], array[a]]
    array
  end
end
