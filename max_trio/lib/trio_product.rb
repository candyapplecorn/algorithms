def trio_product(list)
	pos = LimitedMaxList.new(3)
	neg = LimitedMinList.new(3)

	list.each {|e| e >= 0 ? pos.insert(e) : neg.insert(e) }

	pos = pos.items
	neg = neg.items

	posprod = product(pos)

	return product(neg) if pos.empty?
	return product(pos) if neg.empty?
	return [
		posprod,
		product(neg.sort.take(2), [pos.max])
	].max
end

def product(list1 = [], list2 = [])
	(list1.concat(list2)).inject :*
end


class LimitedMaxList
	attr_reader :items

	def initialize(k)
		@min_pointer = -1
		@max_size = k
		@items = []
		@prc = Proc.new{|a, b| a <=> b}
	end

	def insert(item)
		if @items.empty?
			@items << item
			@min_pointer = 0
		elsif @items.length < @max_size
			@items << item
			if @prc.call(item, @items[@min_pointer]) < 0
				@min_pointer = @items.length - 1
			end
		elsif @prc.call(@items[@min_pointer], item) < 0
			@items[@min_pointer] = item
			set_pointer
		end
	end

	private
	def set_pointer
			@min_pointer = @items.index @items.min
	end
end

class LimitedMinList < LimitedMaxList
	def initialize(k)
		super
		@prc = Proc.new{|a, b| b <=> a }
	end

	private
	def set_pointer
		@min_pointer = @items.index @items.max
	end
end

