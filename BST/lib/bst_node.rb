class BSTNode
	attr_accessor :left, :right
	attr_accessor :value

  def initialize(value)
		@value = value
		@left = nil
		@right = nil
  end
end
