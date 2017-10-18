class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    if @next
      @next.prev = @prev
    end

    if @prev
      @prev.next = @next
    end
  end
end

class LinkedList
  include Enumerable

  def initialize
    @count = 0
    @head = nil
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @count == 0
  end

  def get(key)
    ret = self.find {|n| n.key == key }
    ret ? ret.val : ret
  end

  def getNode(key)
    ret = self.find {|n| n.key == key }
    ret
  end

  def include?(key)
    self.any? {|n| n.key == key}
  end

  def append(key, val)
    @count += 1
    myNode = Node.new(key, val)
    if !@head
      @head = myNode
      @tail = @head
    else

      curr = @head
      while curr && curr.next
        curr = curr.next
      end

      curr.next = myNode
      myNode.prev = curr
      @tail = myNode
    end
  end

  def update(key, val)
    self.each { |node|
      node.val = val if node.key == key }
  end

  def remove(key)
    @count -= 1
    curr = @head

    while curr
      if (curr.key == key)
        if @head == curr
          if curr.next
            @head = curr.next
            curr.next.prev = nil
          else
            @head = nil
          end
        else
          curr.remove
        end
      end

      curr = curr.next
    end
  end

  def each(&block)
    curr = @head
    while curr
      block.call(curr)
      curr = curr.next
    end
  end


  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
