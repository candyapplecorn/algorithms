require_relative 'binary_search_tree'

def counter_gen(k = 0, step = 1)
				Proc.new { k += step; k }
end

def kth_largest(tree_node, k)
				# On the very 1st call, transform k into a closure
				k = counter_gen(k, -1) if k.kind_of? Fixnum

				# Walk all the way to the rightmost (largest) node
				ret = kth_largest(tree_node.right, k) if tree_node.right

				# If the return value isn't nil, it's the kth largest
				return ret unless ret.nil?

				# We've found the kth largest! Return it. The above statement
				# will take care of returning it from the recursive stack
				return tree_node if k.call == 0

				# finally, check the left (smaller) subtrees
				return kth_largest(tree_node.left, k) if tree_node.left
end
